# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	lib-dev/expat
	lib-live/glib:2
	lib-dev/nspr
	>=lib-dev/nss-3.26
	xmedia-live-lib/alsa-lib
	xmedia-live-lib/fontconfig
	xmedia-live-lib/freetype:2
	lib-print/cups
	app-core/dbus
	lib-core/libcap
	xgui-live-lib/cairo
	x11-live-lib/gdk-pixbuf
	x11-live-lib/gtk+:3
	>=x11-live-lib/libX11-1.5.0
	x11-live-lib/libXcomposite
	x11-live-lib/libXcursor
	x11-live-lib/libXdamage
	x11-live-lib/libXext
	x11-live-lib/libXfixes
	x11-live-lib/libXi
	x11-live-lib/libXrandr
	x11-live-lib/libXrender
	x11-live-lib/libXScrnSaver
	x11-live-lib/libXtst
	xgui-live-lib/libxcb
	x11-live-lib/pango
	x11-live-misc/xdg-utils
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
