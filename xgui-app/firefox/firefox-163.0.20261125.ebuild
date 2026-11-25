# Distributed under the terms of the GNU General Public License v2

# cbindgen is a native build tool. Use its published Cargo.lock rather than
# updating Firefox's vendored dependencies or installing from the network.
CBINDGEN_VERSION=0.29.4
CRATES="
	anstream@0.6.19
	anstyle@1.0.11
	anstyle-parse@0.2.7
	anstyle-query@1.1.3
	anstyle-wincon@3.0.9
	autocfg@1.5.0
	bitflags@2.9.1
	cfg-if@1.0.1
	clap@4.5.41
	clap_builder@4.5.41
	clap_lex@0.7.5
	colorchoice@1.0.4
	dashmap@5.5.3
	diff@0.1.13
	equivalent@1.0.2
	errno@0.3.13
	fastrand@2.3.0
	getrandom@0.3.3
	hashbrown@0.14.5
	heck@0.5.0
	indexmap@2.5.0
	is_terminal_polyfill@1.70.1
	itoa@1.0.15
	lazy_static@1.5.0
	libc@0.2.174
	linux-raw-sys@0.9.4
	lock_api@0.4.13
	log@0.4.27
	memchr@2.7.5
	once_cell@1.21.3
	once_cell_polyfill@1.70.1
	parking_lot@0.12.4
	parking_lot_core@0.9.11
	pretty_assertions@1.4.1
	proc-macro2@1.0.95
	quote@1.0.40
	r-efi@5.3.0
	redox_syscall@0.5.13
	rustix@1.0.8
	ryu@1.0.20
	scopeguard@1.2.0
	serde@1.0.228
	serde_core@1.0.228
	serde_derive@1.0.228
	serde_json@1.0.140
	serde_spanned@1.0.0
	serial_test@2.0.0
	serial_test_derive@2.0.0
	smallvec@1.15.1
	strsim@0.11.1
	syn@2.0.104
	tempfile@3.20.0
	toml@0.9.2
	toml_datetime@0.7.0
	toml_parser@1.0.1
	toml_writer@1.0.2
	unicode-ident@1.0.18
	utf8parse@0.2.2
	wasi@0.14.2+wasi-0.2.4
	windows-sys@0.59.0
	windows-targets@0.52.6
	windows_aarch64_gnullvm@0.52.6
	windows_aarch64_msvc@0.52.6
	windows_i686_gnu@0.52.6
	windows_i686_gnullvm@0.52.6
	windows_i686_msvc@0.52.6
	windows_x86_64_gnu@0.52.6
	windows_x86_64_gnullvm@0.52.6
	windows_x86_64_msvc@0.52.6
	winnow@0.7.12
	wit-bindgen-rt@0.39.0
	yansi@1.0.1
"

inherit cargo desktop xdg

DESCRIPTION="Mozilla Firefox web browser with the 1g4 privacy profile"
HOMEPAGE="https://www.mozilla.org/firefox/"
SNAPSHOT=79cae699787ab5cb701a5a1359d70fccc8f4bad4
WASI_SDK=34.0
SRC_URI="
	https://github.com/mozilla-firefox/firefox/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz
	https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_SDK%%.*}/wasi-sysroot-${WASI_SDK}.tar.gz
	https://github.com/WebAssembly/wasi-sdk/releases/download/wasi-sdk-${WASI_SDK%%.*}/libclang_rt-${WASI_SDK}.tar.gz
	https://static.crates.io/crates/cbindgen/cbindgen-${CBINDGEN_VERSION}.crate
	${CARGO_CRATE_URIS}
"
S="${WORKDIR}/firefox-${SNAPSHOT}"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64"
IUSE=""
RESTRICT="test"

# Build against the Gecko snapshot's bundled NSS/NSPR and Rust crates.
DEPEND="
	fonts/fontconfig
	lib-core/glib
	virtual/dbus[X,user-session]
	xgui-lib/cairo[X]
	xgui-lib/freetype
	xgui-lib/gtk3:3[X]
	xgui-lib/libICE
	xgui-lib/libSM
	xgui-lib/libX11
	xgui-lib/libXcomposite
	xgui-lib/libXcursor
	xgui-lib/libXdamage
	xgui-lib/libXext
	xgui-lib/libXfixes
	xgui-lib/libXi
	xgui-lib/libXrandr
	xgui-lib/libxcb
	xgui-lib/pango
	xgui-tools/alsa-lib
	xmedia-lib/pulseaudio
	elibc_musl? ( app-build/llvm[libcxx,syslibcxxabi] )
	elibc_glibc? ( app-build/gcc-lib )
"
RDEPEND="
	${DEPEND}
	!bin/firefox-nightly-bin
	xmedia-app/ffmpeg
	xmedia-lib/libglvnd
"
BDEPEND="
	>=app-build/llvm-23[wasm]
	app-build/make
	app-core/bx
	app-core/findutils
	app-dev/pkgconf
	app-lang/nasm
	app-lang/python
	>=app-lang/rust-1.95.0
	app-server/nodejs
"

PATCHES=( "${FILESDIR}/1g4-firefox.patch" )

src_unpack() {
	cargo_src_unpack
	tar -xzf "${DISTDIR}/cbindgen-${CBINDGEN_VERSION}.crate" || die
}

src_prepare() {
	default

	# Clang and lld run natively on both libcs. The SDK downloads only provide
	# Wasm target files; never execute the glibc-linked SDK host programs.
	local resource_dir
	resource_dir=$(clang -print-resource-dir) || die
	mkdir "${WORKDIR}/wasi-resource" || die
	ln -s "${resource_dir}/include" "${WORKDIR}/wasi-resource/include" || die
	ln -s "${WORKDIR}/libclang_rt-${WASI_SDK}" "${WORKDIR}/wasi-resource/lib" || die

	cat > "${WORKDIR}/mozconfig" <<-EOF || die
		ac_add_options --enable-application=browser
		ac_add_options --enable-default-toolkit=cairo-gtk3-x11-only
		ac_add_options --disable-bootstrap
		ac_add_options --enable-linker=lld
		ac_add_options --disable-updater
		ac_add_options --disable-tests
		ac_add_options --enable-1g4-privacy
		ac_add_options --disable-install-strip
		ac_add_options --prefix=/usr
		ac_add_options --libdir=/usr/lib
		mk_add_options MOZ_OBJDIR=@TOPSRCDIR@/obj
		export MOZ_APP_REMOTINGNAME=firefox-1g4
	EOF
	if use elibc_musl; then
		# Rust's cc crate otherwise defaults to libstdc++ on Linux.
		echo 'mk_add_options "export CXXSTDLIB=c++"' >> "${WORKDIR}/mozconfig" || die
	fi
	mkdir -p "${WORKDIR}"/{firefox-cargo,mozbuild} || die
}

_firefox_build_env() {
	export CC=clang CXX=clang++
	export MOZCONFIG="${WORKDIR}/mozconfig"
	export MACH_BUILD_PYTHON_NATIVE_PACKAGE_SOURCE=none
	export MOZBUILD_STATE_PATH="${WORKDIR}/mozbuild"
	export CARGO_HOME="${WORKDIR}/firefox-cargo" CARGO_NET_OFFLINE=true
	export CBINDGEN="${WORKDIR}/cbindgen-target/release/cbindgen"
	export WASI_SYSROOT="${WORKDIR}/wasi-sysroot-${WASI_SDK}"
	export WASM_CC="clang -resource-dir=\"${WORKDIR}/wasi-resource\""
	export WASM_CXX="clang++ -resource-dir=\"${WORKDIR}/wasi-resource\""
	if [[ -n ${SOURCE_DATE_EPOCH} ]]; then
		local build_date
		build_date=$(date -ud "@${SOURCE_DATE_EPOCH}" +%Y%m%d%H%M%S) || die
		export MOZ_BUILD_DATE="${build_date}"
	fi
}

src_configure() { :; } # Mach configures Firefox after cbindgen is built.

src_compile() {
	cargo_env cargo build --release --locked --offline --bin cbindgen \
		--manifest-path "${WORKDIR}/cbindgen-${CBINDGEN_VERSION}/Cargo.toml" \
		--target-dir "${WORKDIR}/cbindgen-target" -j "$(makeopts_jobs)" || die "cbindgen build failed"

	_firefox_build_env
	filter-flags -fexceptions '-flto*'
	replace-flags '-D_FORTIFY_SOURCE=3' '-D_FORTIFY_SOURCE=2'
	./mach build -j "$(makeopts_jobs)" || die
}

src_install() {
	_firefox_build_env
	DESTDIR="${D}" ./mach install || die
	# Keep the real executable and bundled libraries together; use a relative
	# link for the package image and for installations into alternate roots.
	dosym -r /usr/lib/firefox/firefox /usr/bin/firefox

	local branding=browser/branding/unofficial size
	for size in 16 22 24 32 48 64 128 256; do
		newicon -s "${size}" "${branding}/default${size}.png" firefox.png
	done
	newicon -s scalable "${branding}/content/about-logo.svg" firefox.svg
	domenu "${FILESDIR}/firefox.desktop"
}
