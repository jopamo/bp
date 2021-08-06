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
	lib-gui/at-spi2-atk
	app-compression/bzip2
	app-misc/ca-certificates
	lib-gui/atk
	lib-gui/libxkbcommon
	lib-dev/expat
	lib-dev/glib:2
	lib-dev/nspr
	>=lib-dev/nss-3.26
	lib-media/alsa-lib
	lib-media/fontconfig
	lib-media/freetype:2
	lib-print/cups
	sys-app/dbus
	lib-sys/libcap
	lib-gui/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+:3
	>=x11-libs/libX11-1.5.0
	x11-libs/libXcomposite
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/libXScrnSaver
	x11-libs/libXtst
	lib-gui/libxcb
	x11-libs/pango
	x11-misc/xdg-utils
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
