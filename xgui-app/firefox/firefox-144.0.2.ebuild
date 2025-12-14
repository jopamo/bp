EAPI=8

MOZ_PN="firefox"
MOZ_PV="${PV}"

DESCRIPTION="Mozilla Firefox web browser with PGO and system integration"
HOMEPAGE="https://www.mozilla.org/firefox/"
SRC_URI="https://archive.mozilla.org/pub/firefox/releases/${PV}/source/firefox-${PV}.source.tar.xz -> ${P}.tar.xz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE="wasm"

S="${WORKDIR}/firefox-${PV}"

RESTRICT="network-sandbox"

# same key Arch uses for safe browsing/location
GOOGLE_API_KEY="AIzaSyDwr302FpOSkGRpLlUpPThNTDPbXcIn_FM"

# add real deps:
# BDEPEND: rust, clang/llvm, nodejs, python, llvm-profdata, xvfb, dbus-run-session, sys-apps/findutils, etc
# (we still do cargo-based cbindgen inside sandbox per your request)

src_prepare() {
	default

	# sandbox-local cargo home
	export CARGO_HOME="${T}/cargo-home"
	mkdir -p "${CARGO_HOME}" || die

	# update vendored crates/lockfiles inside sandbox
	(
		cd "${S}" || exit 1
		cargo update
	) || die "cargo update failed"

	# required for mach state cache and PGO profile data
	mkdir -p "${WORKDIR}/mozbuild" || die

	# optional parallel-install patch
	# eapply "${FILESDIR}/0001-Install-under-remoting-name.patch"

	# write Google API key file for safebrowsing/location
	echo -n "${GOOGLE_API_KEY}" > "${S}/google-api-key" || die

	local wasm_opts=""
	if use wasm; then
		wasm_opts+="ac_add_options --with-wasi-sysroot=/usr/share/wasi-sysroot
"
	else
		wasm_opts+="ac_add_options --without-wasm-sandboxed-libraries
"
	fi

	# base mozconfig shared by both instrumented and final builds
	cat > "${T}/mozconfig.base" <<-EOF || die
		ac_add_options --enable-application=browser
		mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj

		ac_add_options --prefix=/usr
		ac_add_options --enable-release
		ac_add_options --enable-hardening
		ac_add_options --enable-optimize
		ac_add_options --enable-rust-simd
		ac_add_options --enable-linker=lld
		ac_add_options --disable-install-strip
		ac_add_options --disable-bootstrap

		${wasm_opts}

		# Branding
		ac_add_options --enable-official-branding
		ac_add_options --enable-update-channel=release
		ac_add_options --with-distribution-id=org.1g4
		ac_add_options --with-unsigned-addon-scopes=app,system
		ac_add_options --allow-addon-sideload
		export MOZILLA_OFFICIAL=1
		export MOZ_APP_REMOTINGNAME=${PN}

		# Keys
		ac_add_options --with-google-location-service-api-keyfile=@TOPSRCDIR@/google-api-key
		ac_add_options --with-google-safebrowsing-api-keyfile=@TOPSRCDIR@/google-api-key

		# System libraries
		ac_add_options --with-system-nspr
		ac_add_options --with-system-nss

		# Features
		ac_add_options --enable-alsa
		ac_add_options --disable-jack
		ac_add_options --enable-crashreporter
		ac_add_options --disable-updater
		ac_add_options --disable-tests
	EOF
}

# prevent Portage from running econf in-tree
src_configure() {
	:
}

src_compile() {
	cd "${S}" || die

	# ensure xargs exists and is visible inside sandbox
	# (configure uses AC_PATH_PROG(XARGS, xargs))
	export PATH="/usr/bin:/bin:${PATH}"
	export XARGS="${XARGS:-/usr/bin/xargs}"

	# sandboxed cargo home
	export CARGO_HOME="${T}/cargo-home"
	mkdir -p "${CARGO_HOME}" || die

	# install cbindgen locally in sandbox
	cargo install --locked --root "${T}/cbindgen" cbindgen || die
	export PATH="${T}/cbindgen/bin:${PATH}"

	export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=pip
	export MOZBUILD_STATE_PATH="${WORKDIR}/mozbuild"
	if [[ -n ${SOURCE_DATE_EPOCH} ]]; then
		export MOZ_BUILD_DATE="$(date -ud "@${SOURCE_DATE_EPOCH}" +%Y%m%d%H%M%S)"
	else
		export MOZ_BUILD_DATE="$(date -u +%Y%m%d%H%M%S)"
	fi
	export MOZ_NOSPAM=1

	# adjust fortify to 2 because 3 breaks with malloc_usable_size use
	CFLAGS=${CFLAGS//_FORTIFY_SOURCE=3/_FORTIFY_SOURCE=2}
	CXXFLAGS=${CXXFLAGS//_FORTIFY_SOURCE=3/_FORTIFY_SOURCE=2}

	# drop -fexceptions due to upstream bug 1896066
	CFLAGS=${CFLAGS//-fexceptions/}
	CXXFLAGS=${CXXFLAGS//-fexceptions/}

	# LTO and link steps want more fds
	ulimit -n 4096 || die

	# stage 1: instrumented build with profile-generate
	einfo "Building instrumented browser"
	cp "${T}/mozconfig.base" .mozconfig || die
	cat >> .mozconfig <<-EOF || die
		ac_add_options --enable-profile-generate=cross
	EOF

	./mach build --priority normal || die
	./mach package || die

	# run profileserver under xvfb + dbus-run-session to collect PGO data
	einfo "Profiling instrumented browser"
	LLVM_PROFDATA=llvm-profdata JARLOG_FILE="${PWD}/jarlog" \
		dbus-run-session \
		xvfb-run -s "-screen 0 1920x1080x24 -nolisten local" \
		./mach python build/pgo/profileserver.py || die

	[[ -s merged.profdata ]] || die "PGO profile data missing"
	[[ -s jarlog ]] || die "Jar log missing"

	einfo "Removing instrumented browser"
	./mach clobber objdir || die

	# stage 2: final optimized build with PGO and LTO
	einfo "Building optimized browser"
	cp "${T}/mozconfig.base" .mozconfig || die
	cat >> .mozconfig <<-EOF || die
		ac_add_options --enable-lto=cross,full
		ac_add_options --enable-profile-use=cross
		ac_add_options --with-pgo-profile-path=${PWD}/merged.profdata
		ac_add_options --with-pgo-jarlog=${PWD}/jarlog
	EOF

	./mach build --priority normal || die
}

src_install() {
	cd "${S}" || die

	DESTDIR="${D}" ./mach install || die

	local libdir="/usr/lib/${PN}"

	# vendor prefs
	local vendorjs="${T}/vendor.js"
	cat > "${vendorjs}" <<-EOF || die
	// Use LANG environment variable to choose locale
	pref("intl.locale.requested", "");

	// Use system-provided dictionaries
	pref("spellchecker.dictionary_path", "/usr/share/hunspell");

	// Disable default browser checking
	pref("browser.shell.checkDefaultBrowser", false);

	// Don't disable extensions in the application directory
	pref("extensions.autoDisableScopes", 11);

	// Enable GNOME Shell search provider
	pref("browser.gnome-search-provider.enabled", true);
	EOF

	insinto "${libdir}/browser/defaults/preferences"
	doins "${vendorjs}"

	# distribution info
	local distini="${T}/distribution.ini"
	cat > "${distini}" <<-EOF || die
	[Global]
	id=1g4
	version=1.0
	about=Mozilla Firefox for 1g4 Linux

	[Preferences]
	app.distributor=1g4
	app.distributor.channel=${PN}
	app.partner.1g4=1g4
	EOF

	insinto "${libdir}/distribution"
	doins "${distini}"

	# link system ONNX runtime into firefox dir
	dosym ../libonnxruntime.so "${libdir}/libonnxruntime.so"

	# icons
	local theme="official"
	local i
	for i in 16 22 24 32 48 64 128 256; do
		newicon -s "${i}" "browser/branding/${theme}/default${i}.png" "${PN}.png"
	done

	insinto /usr/share/icons/hicolor/192x192/apps
	doins "browser/branding/${theme}/content/about-logo.png"

	insinto /usr/share/icons/hicolor/384x384/apps
	doins "browser/branding/${theme}/content/about-logo@2x.png"

	insinto /usr/share/icons/hicolor/scalable/apps
	doins "browser/branding/${theme}/content/about-logo.svg"

	# wrapper script to provide clean binary name
	newbin - "${PN}" <<-EOF
	#!/bin/sh
	exec /usr/lib/${PN}/firefox "\$@"
	EOF

	# firefox-bin wrapper inside libdir to avoid duplication
	dosym "/usr/bin/${PN}" "${libdir}/firefox-bin"

	# GNOME Shell search provider
	local sprovider="${T}/${PN}.search-provider.ini"
	cat > "${sprovider}" <<-EOF || die
	[Shell Search Provider]
	DesktopId=${PN}.desktop
	BusName=org.mozilla.${PN//-/_}.SearchProvider
	ObjectPath=/org/mozilla/${PN//-/_}/SearchProvider
	Version=2
	EOF

	insinto /usr/share/gnome-shell/search-providers
	doins "${sprovider}"
}
