# Distributed under the terms of the GNU General Public License v2

# Latest Version
# wget -q -O - "http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/LAST_CHANGE"

EAPI=7

inherit unpacker

DESCRIPTION="A web browser built for speed, simplicity, and security"
HOMEPAGE="https://www.chromium.org/"
SRC_URI="amd64? ( http://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/${PV}/chrome-linux.zip -> ${P}.zip )"
S="${WORKDIR}"

RESTRICT="strip mirror"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	xgui-live-lib/at-spi2-atk
	app-compression/bzip2
	app-misc/ca-certificates
	xgui-live-lib/atk
	lib-core/expat
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
	xgui-live-lib/wayland
"

QA_PREBUILT="*"

src_install() {
	mkdir -p "${ED}"/opt || die
	cp -rp chrome-linux "${ED}"/opt/ || die

	# Create /usr/bin/${PN}
	dodir /usr/bin/
	cat <<-EOF >"${D}"/usr/bin/${PN}
	#!/bin/sh
	exec /opt/chrome-linux/chrome "\$@"
	EOF
	fperms 0755 /usr/bin/${PN}
	fperms 0755 /opt/chrome-linux/chrome

	rm -f "${ED}"/opt/chrome-linux/locales/{a*,b*,c*,d*,e{l,o,s,t,u}*,en-GB*,f*,g*,h*,i{a,d,g,k,t,u}*,j*,k*,l*,m*,n*,o*,p*,q*,r*,s*,t*,u*,v*,w*,x*,y*,z*}

	rm -f "${ED}"/opt/chrome-linux/WidevineCdm
}
