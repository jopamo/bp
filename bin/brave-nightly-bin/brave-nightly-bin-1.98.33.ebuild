# Distributed under the terms of the GNU General Public License v2

inherit unpacker xdg

DESCRIPTION="Brave Browser Nightly: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"

BASE_URI="https://github.com/brave/brave-browser/releases/download"

SRC_URI="
	amd64? ( ${BASE_URI}/v${PV}/brave-origin-nightly_${PV}_amd64.deb -> ${PN}-${PV}-amd64.deb )
	arm64? ( ${BASE_URI}/v${PV}/brave-origin-nightly_${PV}_arm64.deb -> ${PN}-${PV}-arm64.deb )
"

S="${WORKDIR}"

LICENSE="BRAVE"

SLOT="0"
RESTRICT="strip mirror"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-compression/bzip2
	virtual/dbus
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-core/glib
	lib-print/cups
	xgui-icontheme/adwaita-icon-theme
	xgui-lib/at-spi2-core
	xgui-lib/cairo
	xgui-lib/gdk-pixbuf
	xgui-lib/gtk3
	xgui-lib/libxcb
	xgui-lib/libxkbcommon
	xgui-lib/pango
	xgui-tools/alsa-lib
	xgui-lib/freetype
"

QA_PREBUILT="*"

src_unpack() {
	unpacker_src_unpack
}

src_install() {
	local brave_root
	if [[ -d opt/brave.com/brave-origin-nightly ]]; then
		brave_root=brave-origin-nightly
	elif [[ -d opt/brave.com/brave-nightly ]]; then
		brave_root=brave-nightly
	else
		die "unknown Brave nightly payload layout"
	fi

	local brave_exec=
	local candidate
	for candidate in brave-origin-nightly brave-browser-nightly brave; do
		if [[ -x opt/brave.com/${brave_root}/${candidate} ]]; then
			brave_exec=${candidate}
			break
		fi
	done
	[[ -n ${brave_exec} ]] || die "missing Brave nightly executable in payload"

	mkdir -p "${ED}"/opt || die
	cp -rp opt/brave.com "${ED}"/opt/ || die

	dodir /usr/bin || die
	local wrapper
	for wrapper in ${PN} brave-origin-nightly brave-browser-nightly; do
		cat > "${ED}"/usr/bin/${wrapper} <<-EOF || die
		#!/bin/sh
		exec /opt/brave.com/${brave_root}/${brave_exec} "\$@"
		EOF
		fperms 0755 /usr/bin/${wrapper}
	done

	fperms 0755 /opt/brave.com/${brave_root}/${brave_exec}
	fperms 4755 /opt/brave.com/${brave_root}/chrome-sandbox

	insopts -m 0644
	insinto /usr/share/applications
	local desktop_file
	for desktop_file in \
		usr/share/applications/brave-origin-nightly.desktop \
		usr/share/applications/com.brave.Origin.nightly.desktop \
		usr/share/applications/brave-browser-nightly.desktop \
		usr/share/applications/brave-browser.desktop
	do
		[[ -f ${desktop_file} ]] && doins "${desktop_file}"
	done

	if [[ -d usr/share/icons/hicolor ]]; then
		insinto /usr/share/icons
		doins -r usr/share/icons/hicolor
	fi
	if [[ -f usr/share/pixmaps/brave-browser-nightly.png ]]; then
		insinto /usr/share/pixmaps
		doins usr/share/pixmaps/brave-browser-nightly.png
	elif [[ -f usr/share/pixmaps/brave-browser.png ]]; then
		insinto /usr/share/pixmaps
		doins usr/share/pixmaps/brave-browser.png
	fi

	insopts -m 0644
	insinto /usr/share/pixmaps/
	newins "${FILESDIR}"/brave.svg ${PN}.svg
	newins "${FILESDIR}"/brave.svg brave-origin-nightly.svg
	newins "${FILESDIR}"/brave.svg brave-browser-nightly.svg
}
