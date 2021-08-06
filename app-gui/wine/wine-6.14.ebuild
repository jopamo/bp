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
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXi
		x11-libs/libXxf86vm
	)
	alsa? ( lib-media/alsa-lib )
	cups? ( lib-print/cups:= )
	fontconfig? ( lib-media/fontconfig:= )
	jpeg? ( lib-media/libjpeg-turbo )
	ldap? ( app-net/openldap:= )
	mp3? ( >=lib-media/mpg123-1.5.0 )
	netapi? ( app-server/samba )
	openal? ( lib-media/openal:= )
	opengl? (
		lib-media/glu
		lib-media/mesa
	)
	pcap? ( lib-net/libpcap )
	png? ( lib-media/libpng:0= )
	pulseaudio? ( app-media/pulseaudio )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )
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
	X? ( x11-misc/xorgproto )
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
