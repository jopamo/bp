# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Google Chromium, sans integration with Google"
HOMEPAGE="https://brave.com"
SRC_URI="
	https://github.com/ungoogled-software/ungoogled-chromium-portablelinux/releases/download/${PV}-1/ungoogled-chromium_${PV}-1_linux.tar.xz
"
S="${WORKDIR}/ungoogled-chromium_${PV}-1_linux"

RESTRICT="strip mirror"

LICENSE="CHROME"
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
	mkdir -p "${ED}"/opt/chromium
	cp -rp "${S}"/* "${ED}"/opt/chromium/

	# Create /usr/bin/google-chrome-unstable
	dodir /usr/bin/
	cat <<-EOF >chromium
	#!/bin/sh
	exec /opt/google/chrome-unstable/google-chrome-unstable "\$@"
	EOF

	dobin chromium

	fperms 0755 /opt/chromium/chrome
	fperms 0755 /opt/chromium/chrome_crashpad_handler
	fperms 4755 /opt/chromium/chrome_sandbox

	insopts -m 0644
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/chromium.png
}
