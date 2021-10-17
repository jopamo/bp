# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic

DESCRIPTION="Compatibility layer capable of running Windows applications."
HOMEPAGE="https://www.winehq.org/"
SRC_URI="https://dl.winehq.org/wine/source/$(ver_cut 1).x/${P}.tar.xz
	https://github.com/wine-staging/wine-staging/archive/v${PV}.tar.gz -> wine-staging-patches-${PV}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+alsa cups custom-cflags +fontconfig +jpeg ldap mp3 netapi nls odbc openal opencl
 +opengl perl pcap +png prelink pulseaudio samba +staging test +X +xcomposite
 xinerama +xml"

RESTRICT="test"

COMMON_DEPEND="
	X? (
		xgui-live-lib/libXcursor
		xgui-live-lib/libXext
		xgui-live-lib/libXfixes
		xgui-live-lib/libXrandr
		xgui-live-lib/libXi
		xgui-live-lib/libXxf86vm
	)
	alsa? ( xgui-misc/alsa-lib )
	cups? ( lib-print/cups:= )
	fontconfig? ( fonts/fontconfig:= )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	ldap? ( app-net/openldap:= )
	mp3? ( xgui-misc/mpg123 )
	netapi? ( app-server/samba )
	openal? ( xmedia-live-lib/openal:= )
	opengl? (
		xmedia-live-lib/glu
		xmedia-live-lib/mesa
	)
	pcap? ( lib-net/libpcap )
	png? ( xmedia-live-lib/libpng:0= )
	pulseaudio? ( xgui-misc/pulseaudio )
	xcomposite? ( xgui-live-lib/libXcomposite )
	xinerama? ( xgui-live-lib/libXinerama )
	xml? (
		lib-core/libxml2
		lib-core/libxslt
	)
"

RDEPEND="${COMMON_DEPEND}
	perl? (	dev-lang/perl )
	samba? ( >=app-server/samba-3.0.25[winbind] )"

DEPEND="${COMMON_DEPEND}
	sys-devel/flex
	dev-util/pkgconf
	sys-devel/bison
	X? ( xgui-live-app/xorgproto )
"

filter-flags -flto\=\* -Wl,-z,defs

src_prepare() {
	default
	use staging && ${WORKDIR}/wine-staging-${PV}/patches/patchinstall.sh DESTDIR="${S}" --all
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
