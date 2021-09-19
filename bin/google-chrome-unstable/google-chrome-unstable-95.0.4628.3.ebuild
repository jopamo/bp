# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker

MY_P="${PN}_${PV}-1"

DESCRIPTION="Brave Browser: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${PN}/${MY_P}_amd64.deb"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="CHROME"
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
	lib-dev/nss
	xmedia-live-lib/alsa-lib
	xmedia-live-lib/fontconfig
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
"

QA_PREBUILT="*"

src_install() {
	insinto /opt
	doins -r opt/google

	# Create /usr/bin/${PN}
	dodir /usr/bin/
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	exec /opt/google/chrome-unstable/google-chrome-unstable "\$@"
	EOF

	fperms 0755 /usr/bin/${PN}
	fperms 0755 /opt/google/chrome-unstable/google-chrome-unstable
	fperms 0755 /opt/google/chrome-unstable/chrome
	fperms 0755 /opt/google/chrome-unstable/chrome_crashpad_handler
	fperms 4755 /opt/google/chrome-unstable/chrome-sandbox
}
