# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT="3dcd383186ef2d72f2ac200ef69677458b6485d2"

inherit autotools flag-o-matic xdg

DESCRIPTION="Compatibility layer capable of running Windows applications."
HOMEPAGE="https://www.winehq.org/"
SRC_URI="https://dl.winehq.org/wine/source/$(ver_cut 1).x/${P}.tar.xz
		https://github.com/wine-staging/wine-staging/archive/${SNAPSHOT}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+alsa cups custom-cflags +fontconfig +jpeg ldap mp3 netapi nls odbc openal opencl
 +opengl perl pcap +png prelink pulseaudio samba +staging test +X +xcomposite
 xinerama +xml unwind usb"

RESTRICT="test"

DEPEND="
	X? (
		xgui-live-lib/libXcursor
		xgui-live-lib/libXext
		xgui-live-lib/libXfixes
		xgui-live-lib/libXrandr
		xgui-live-lib/libXi
		xgui-live-lib/libXxf86vm
	)
	alsa? ( xgui-misc/alsa-lib )
	cups? ( lib-print/cups )
	fontconfig? ( fonts/fontconfig )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	ldap? ( app-net/openldap )
	mp3? ( xgui-misc/mpg123 )
	netapi? ( app-server/samba )
	openal? ( xmedia-live-lib/openal )
	opengl? (
		xmedia-live-lib/glu
		xgui-misc/mesa
	)
	pcap? ( lib-net/libpcap )
	perl? (	app-lang/perl )
	png? ( xmedia-live-lib/libpng )
	pulseaudio? ( xgui-misc/pulseaudio )
	samba? ( app-server/samba[winbind] )
	xcomposite? ( xgui-live-lib/libXcomposite )
	xinerama? ( xgui-live-lib/libXinerama )
	xml? (
		lib-core/libxml2
		lib-core/libxslt
	)
	unwind? (	lib-live/libunwind )
	usb? (	lib-dev/libusb )
"
BDEPEND="
	app-build/flex
	app-dev/pkgconf
	app-build/bison
	X? ( xgui-live-app/xorgproto )
"

src_prepare() {
	filter-flags -flto* -Wl,-z,defs

	default
	use staging && ${WORKDIR}/wine-staging-${SNAPSHOT}/staging/patchinstall.py DESTDIR="${S}" --all
}

src_configure() {
	local myconf=(
		--enable-win64
		$(use_with cups)
		$(use_with fontconfig)
		$(use_with jpeg)
		$(use_with ldap)
		$(use_with mp3 mpg123)
		$(use_with netapi)
		$(use_with openal)
		$(use_with opengl)
		$(use_with pcap)
		$(use_with png)
		$(use_with pulseaudio pulse)
		$(use_with unwind)
		$(use_with usb)
		$(use_with xcomposite)
		$(use_with xinerama)
		$(use_with xml)
	)
	econf ${myconf[@]}
}

src_install() {
	default
	rm -rf "${ED}"/usr/share/man/{de,fr}.UTF-8
}
