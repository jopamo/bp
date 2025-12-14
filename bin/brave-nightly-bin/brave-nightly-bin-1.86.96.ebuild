# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Brave Browser Nightly: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"

BASE_URI="https://github.com/brave/brave-browser/releases/download"

SRC_URI="
	amd64? ( ${BASE_URI}/v${PV}/brave-browser-nightly_${PV}_amd64.deb -> ${PN}-${PV}-amd64.deb )
	arm64? ( ${BASE_URI}/v${PV}/brave-browser-nightly_${PV}_arm64.deb -> ${PN}-${PV}-arm64.deb )
"

S="${WORKDIR}"

LICENSE="BRAVE"

RESTRICT="strip mirror"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-compression/bzip2
	app-core/dbus
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-util/glib
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
	mkdir -p "${ED}"/opt || die
	cp -rp opt/brave.com "${ED}"/opt/ || die

	dodir /usr/bin || die
	cat > "${D}"/usr/bin/${PN} <<-'EOF' || die
	#!/bin/sh
	exec /opt/brave.com/brave-nightly/brave-browser-nightly "$@"
	EOF
	fperms 0755 /usr/bin/${PN}

	fperms 0755 /opt/brave.com/brave-nightly/brave-browser-nightly
	fperms 4755 /opt/brave.com/brave-nightly/chrome-sandbox

	if [[ -f usr/share/applications/brave-browser-nightly.desktop ]]; then
		insopts -m 0644
		insinto /usr/share/applications
		doins usr/share/applications/brave-browser-nightly.desktop
	elif [[ -f usr/share/applications/brave-browser.desktop ]]; then
		insopts -m 0644
		insinto /usr/share/applications
		doins usr/share/applications/brave-browser.desktop
	fi

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
	doins "${FILESDIR}"/brave.svg
}
