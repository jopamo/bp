# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit unpacker xdg

DESCRIPTION="Brave Browser: Secure, Fast & Private Web Browser with Adblocker"
HOMEPAGE="https://brave.com"
SRC_URI="amd64? ( https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-nightly_${PV}_amd64.deb )"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="BRAVE"
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
	xgui-misc/freetype
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

	insopts -m 0644
	insinto /usr/share/pixmaps
	doins "${FILESDIR}"/brave.svg
}
