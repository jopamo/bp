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
	lib-gui/at-spi2-atk
	app-compression/bzip2
	app-misc/ca-certificates
	lib-gui/atk
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
	lib-dev/wayland
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
