# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools multilib-minimal eutils

if [[ ${PV} == "9999" ]] ; then
	EGIT_REPO_URI="https://github.com/wine-mirror/wine.git"
	inherit git-r3
else
	SRC_URI="https://github.com/wine-mirror/wine/archive/${P}.tar.gz
			staging? ( https://github.com/wine-staging/wine-staging/archive/v${PV}.tar.gz )"
	S=${WORKDIR}/wine-wine-${PV}
	KEYWORDS="amd64 arm64 x86"
fi

DESCRIPTION="Free implementation of Windows(tm) on Unix, without external patchsets"
HOMEPAGE="https://www.winehq.org/"

LICENSE="LGPL-2.1"
SLOT="${PV}"
IUSE="+abi_x86_32 +abi_x86_64 +alsa capi cups custom-cflags dos elibc_glibcpath +fontconfig gphoto2 gsm +jpeg  kernel_FreeBSD +lcms ldap +mono mp3 ncurses netapi nls odbc openal opencl +opengl osmesa oss +perl pcap +png prelink pulseaudio +realtime +run-exes samba scanner selinux +ssl +staging test +threads +truetype udev +udisks v4l +X +xcomposite xinerama +xml"
REQUIRED_USE="|| ( abi_x86_32 abi_x86_64 )
	X? ( truetype )
	elibc_glibc? ( threads )
	osmesa? ( opengl )
	test? ( abi_x86_32 )" # osmesa-opengl #286560 # X-truetype #551124

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
	capi? ( lib-net/libcapi )
	cups? ( lib-print/cups:= )
	fontconfig? ( lib-media/fontconfig:= )
	gphoto2? ( lib-media/libgphoto2:= )
	gsm? ( app-media/gsm:= )
	jpeg? ( lib-media/libjpeg-turbo )
	lcms? ( lib-media/lcms:2= )
	ldap? ( net-nds/openldap:= )
	mp3? ( >=app-media/mpg123-1.5.0 )
	ncurses? ( >=lib-sys/ncurses-5.2:0= )
	netapi? ( app-server/samba )
	nls? ( sys-devel/gettext )
	odbc? ( dev-db/unixODBC:= )
	openal? ( lib-media/openal:= )
	opencl? ( virtual/opencl )
	opengl? (
		lib-media/glu
		lib-media/mesa
	)
	osmesa? ( >=lib-media/mesa-13 )
	pcap? ( lib-net/libpcap )
	png? ( lib-media/libpng:0= )
	pulseaudio? ( app-media/pulseaudio )
	scanner? ( app-media/sane-backends:= )
	ssl? ( lib-net/gnutls:= )
	truetype? ( >=lib-media/freetype-2.0.0 )
	udev? ( sys-app/systemd:= )
	udisks? ( sys-app/dbus )
	v4l? ( lib-media/libv4l )
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-libs/libXinerama )
	xml? (
		lib-dev/libxml2
		lib-dev/libxslt
	)
"

RDEPEND="${COMMON_DEPEND}
	dos? ( >=games-emulation/dosbox-0.74_p20160629 )
	perl? (
		dev-lang/perl
	)
	samba? ( >=app-server/samba-3.0.25[winbind] )
	selinux? ( sec-policy/selinux-wine )
"

# tools/make_requests requires perl
DEPEND="${COMMON_DEPEND}
	sys-devel/flex
	>=sys-kernel/stable-sources-2.6
	dev-util/pkgconfig
	sys-devel/bison
	X? ( x11/xorgproto )
"

src_prepare() {
	${WORKDIR}/wine-staging-${PV}/patches/patchinstall.sh DESTDIR="${S}" --all
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--enable-win64
	)
	econf ${myconf[@]}
}

