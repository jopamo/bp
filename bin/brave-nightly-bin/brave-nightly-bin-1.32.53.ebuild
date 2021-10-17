# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

DESCRIPTION="Brave Browser: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"
SRC_URI="amd64? ( https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-nightly_${PV}_amd64.deb )"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="BRAVE"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	xgui-live-lib/at-spi2-atk
	app-compression/bzip2
	app-misc/ca-certificates
	xgui-live-lib/atk
	xgui-live-lib/libxkbcommon
	lib-core/expat
	lib-live/glib
	lib-dev/nspr
	>=lib-dev/nss-3.26
	xgui-misc/alsa-lib
	fonts/fontconfig
	xgui-misc/freetype
	lib-print/cups
	app-core/dbus
	lib-core/libcap
	xgui-live-lib/cairo
	xgui-live-lib/gdk-pixbuf
	xgui-live-lib/gtk+:3
	xgui-live-lib/libX11
	xgui-live-lib/libXcomposite
	xgui-live-lib/libXcursor
	xgui-live-lib/libXdamage
	xgui-live-lib/libXext
	xgui-live-lib/libXfixes
	xgui-live-lib/libXi
	xgui-live-lib/libXrandr
	xgui-live-lib/libXrender
	xgui-live-lib/libXScrnSaver
	xgui-live-lib/libXtst
	xgui-live-lib/libxcb
	xgui-live-lib/pango
	xgui-live-app/xdg-utils
	xgui-icontheme/adwaita-icon-theme
"

QA_PREBUILT="*"

src_install() {
	mkdir -p "${ED}"/opt || die
	cp -rp opt/brave.com "${ED}"/opt/ || die

	# Create /usr/bin/${PN}
	dodir /usr/bin/
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	exec /opt/brave.com/brave-nightly/brave-browser-nightly "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}
	fperms 0755 /opt/brave.com/brave-nightly/brave-browser-nightly
	fperms 4755 /opt/brave.com/brave-nightly/chrome-sandbox
}
