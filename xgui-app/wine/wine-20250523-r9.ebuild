# Distributed under the terms of the GNU General Public License v2

EAPI=8

SNAPSHOT=22af42ac22279e6c0c671f033661f95c1761b4bb
SNAPSHOT2="a3738434e05ba4e378cec59c723304ba33759fdc"

inherit autotools flag-o-matic xdg

DESCRIPTION="Compatibility layer capable of running Windows applications."
HOMEPAGE="https://www.winehq.org/"

SRC_URI="
	https://github.com/wine-mirror/wine/archive/${SNAPSHOT}.tar.gz -> wine-${SNAPSHOT}.tar.gz
	https://github.com/wine-staging/wine-staging/archive/${SNAPSHOT2}.tar.gz -> wine-staging-${SNAPSHOT2}.tar.gz
"

S="${WORKDIR}/wine-${SNAPSHOT}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="alsa cups custom-cflags fontconfig jpeg ldap mp3 netapi nls odbc openal opencl
 +opengl perl pcap +png prelink pulseaudio samba +staging test +X +xcomposite
 xinerama +xml unwind usb"

RESTRICT="test"

DEPEND="
	X? (
		xgui-lib/libXcursor
		xgui-lib/libXext
		xgui-lib/libXfixes
		xgui-lib/libXrandr
		xgui-lib/libXi
		xgui-lib/libXxf86vm
	)
	alsa? ( xgui-tools/alsa-lib )
	cups? ( lib-print/cups )
	fontconfig? ( fonts/fontconfig )
	jpeg? ( xmedia-lib/libjpeg-turbo )
	ldap? ( app-net/openldap )
	mp3? ( xgui-app/mpg123 )
	netapi? ( app-server/samba )
	openal? ( xmedia-live-lib/openal )
	opengl? (
		xmedia-lib/glu
		xgui-tools/mesa
	)
	pcap? ( lib-net/libpcap )
	perl? (	app-lang/perl )
	png? ( xmedia-lib/libpng )
	pulseaudio? ( xgui-misc/pulseaudio )
	samba? ( app-server/samba[winbind] )
	xcomposite? ( xgui-lib/libXcomposite )
	xinerama? ( xgui-lib/libXinerama )
	xml? (
		lib-core/libxml2
		lib-core/libxslt
	)
	unwind? (	lib-util/libunwind )
	usb? (	lib-dev/libusb )
"
BDEPEND="
	app-build/flex
	app-dev/pkgconf
	app-build/bison
	X? ( xgui-tools/xorgproto )
"

src_prepare() {
	filter-flags -flto* -Wl,-z,defs

	default

	"${WORKDIR}/wine-staging-${SNAPSHOT2}/staging/patchinstall.py" DESTDIR="${S}" --all
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
