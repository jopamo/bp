# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
		x11-live-lib/libXcursor
		x11-live-lib/libXext
		x11-live-lib/libXfixes
		x11-live-lib/libXrandr
		x11-live-lib/libXi
		x11-live-lib/libXxf86vm
	)
	alsa? ( xmedia-live-lib/alsa-lib )
	cups? ( lib-print/cups:= )
	fontconfig? ( xmedia-live-lib/fontconfig:= )
	jpeg? ( xmedia-live-lib/libjpeg-turbo )
	ldap? ( app-net/openldap:= )
	mp3? ( >=xmedia-live-lib/mpg123-1.5.0 )
	netapi? ( app-server/samba )
	openal? ( xmedia-live-lib/openal:= )
	opengl? (
		xmedia-live-lib/glu
		xmedia-live-lib/mesa
	)
	pcap? ( lib-net/libpcap )
	png? ( xmedia-live-lib/libpng:0= )
	pulseaudio? ( xmedia-live-app/pulseaudio )
	xcomposite? ( x11-live-lib/libXcomposite )
	xinerama? ( x11-live-lib/libXinerama )
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
	X? ( x11-live-misc/xorgproto )
"

filter-flags -flto\=\* -Wl,-z,defs
append-ldflags -lresolv

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
