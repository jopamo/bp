# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

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
	app-compression/bzip2
	app-core/dbus
	app-var/ca-certificates
	fonts/fontconfig
	lib-core/expat
	lib-core/libcap
	lib-dev/nspr
	lib-dev/nss
	lib-live/glib
	lib-print/cups
	xgui-icontheme/adwaita-icon-theme
	xgui-live-lib/at-spi2-core
	xgui-live-lib/cairo
	xgui-live-lib/gdk-pixbuf
	xgui-live-lib/gtk+:3
	xgui-live-lib/libxcb
	xgui-live-lib/libxkbcommon
	xgui-live-lib/pango
	xgui-misc/alsa-lib
	xgui-misc/freetype
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
