# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

MY_P="${PN}_${PV}-1"

DESCRIPTION="Google Chrome web browser (unstable channel)"
HOMEPAGE="https://www.google.com/chrome/"
SRC_URI="https://dl.google.com/linux/chrome/deb/pool/main/g/${PN}/${MY_P}_amd64.deb"
S="${WORKDIR}"

LICENSE="CHROME"

RESTRICT="strip mirror"
SLOT="0"
KEYWORDS="amd64"

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

	insopts -m 0644
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/chrome.svg
}
