# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/wine-mirror/wine.git"
	inherit git-r3
else
	SRC_URI="https://github.com/wine-mirror/wine/archive/${P}.tar.gz
			staging? ( https://github.com/wine-staging/wine-staging/archive/v${PV}.tar.gz )"
	S=${WORKDIR}/wine-wine-${PV}
	KEYWORDS="amd64 arm64"
fi

DESCRIPTION="Free implementation of Windows(tm) on Unix, without external patchsets"
HOMEPAGE="https://www.winehq.org/"

LICENSE="LGPL-2.1"
SLOT="${PV}"
IUSE="+alsa cups custom-cflags +fontconfig +jpeg ldap mp3 netapi nls odbc openal +opencl
 +opengl osmesa perl pcap +png prelink pulseaudio samba test +X +xcomposite
 xinerama +xml"

REQUIRED_USE="osmesa? ( opengl )"

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
	ldap? ( net-nds/openldap:= )
	mp3? ( >=lib-media/mpg123-1.5.0 )
	netapi? ( app-server/samba )
	openal? ( lib-media/openal:= )
	opengl? (
		lib-media/glu
		lib-media/mesa
	)
	osmesa? ( >=lib-media/mesa-13 )
	pcap? ( lib-net/libpcap )
	png? ( lib-media/libpng:0= )
	pulseaudio? ( app-media/pulseaudio )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )
	xml? (
		lib-dev/libxml2
		lib-dev/libxslt
	)
"

RDEPEND="${COMMON_DEPEND}
	perl? (	dev-lang/perl )
	samba? ( >=app-server/samba-3.0.25[winbind] )"

DEPEND="${COMMON_DEPEND}
	sys-devel/flex
	dev-util/pkgconfig
	sys-devel/bison
	X? ( x11/xorgproto )
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_prepare() {
	${WORKDIR}/wine-staging-${PV}/patches/patchinstall.sh DESTDIR="${S}" --all
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-win64
		$(use_with cups)
		$(use_with fontconfig)
		$(use_with jpeg)
		$(use_with ldap)
		$(use_with mp3 mpg123)
		$(use_with netapi)
		$(use_with openal)
		$(use_with opencl)
		$(use_with opengl)
		$(use_with osmesa)
		$(use_with pcap)
		$(use_with png)
		$(use_with pulseaudio pulse)
		$(use_with xcomposite)
		$(use_with xinerama)
		$(use_with xml)
	)
	econf ${myconf[@]}
}

