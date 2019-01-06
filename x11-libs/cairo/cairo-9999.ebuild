# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils flag-o-matic autotools multilib-minimal

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://anongit.freedesktop.org/git/cairo"
	KEYWORDS="amd64 arm64 x86"
else
	SRC_URI="https://www.cairographics.org/releases/${P}.tar.xz"
fi

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="https://www.cairographics.org"
LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
IUSE="X aqua debug doc gles2 +glib opengl static-libs +svg utils valgrind xcb"

RESTRICT="test"

RDEPEND="
	>=lib-media/fontconfig-2.10.92[${MULTILIB_USEDEP}]
	>=lib-media/freetype-2.5.0.1:2[${MULTILIB_USEDEP}]
	>=lib-media/libpng-1.6.10:0=[${MULTILIB_USEDEP}]
	>=lib-sys/zlib-1.2.8-r1[${MULTILIB_USEDEP}]
	>=x11-libs/pixman-0.32.4[${MULTILIB_USEDEP}]
	>=lib-media/mesa-9.1.6[${MULTILIB_USEDEP}]
	glib? ( >=lib-dev/glib-2.34.3:2[${MULTILIB_USEDEP}] )
	opengl? ( >=lib-media/mesa-9.1.6[${MULTILIB_USEDEP}] )
	utils? ( >=lib-dev/lzo-2.06-r1[${MULTILIB_USEDEP}] )
	X? (
		>=x11-libs/libXrender-0.9.8[${MULTILIB_USEDEP}]
		>=x11-libs/libXext-1.3.2[${MULTILIB_USEDEP}]
		>=x11-libs/libX11-1.6.2[${MULTILIB_USEDEP}]
	)
	xcb? (
		>=x11-libs/libxcb-1.9.1[${MULTILIB_USEDEP}]
	)
	abi_x86_32? (
		!<=app-misc/emul-linux-x86-gtklibs-20131008-r1
		!app-misc/emul-linux-x86-gtklibs[-abi_x86_32(-)]
	)"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=sys-devel/libtool-2
	X? ( x11/xorgproto )"

REQUIRED_USE="
	gles2? ( !opengl )
"

PATCHES=(
	"${FILESDIR}"/${PN}-1.12.18-disable-test-suite.patch
	"${FILESDIR}"/${PN}-respect-fontconfig.patch
)

filter-flags -flto

src_prepare() {
	default

	# tests and perf tools require X, bug #483574
	if ! use X; then
		sed -e '/^SUBDIRS/ s#boilerplate test perf# #' -i Makefile.am || die
	fi

	# Slightly messed build system YAY
	if [[ ${PV} == *9999* ]]; then
		touch boilerplate/Makefile.am.features
		touch src/Makefile.am.features
		touch ChangeLog
	fi

	eautoreconf
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dependency-tracking
		$(use_with X x)
		$(use_enable X tee)
		$(use_enable X xlib)
		$(use_enable X xlib-xrender)
		$(use_enable aqua quartz)
		$(use_enable aqua quartz-image)
		$(use_enable debug test-surfaces)
		$(use_enable doc gtk-doc)
		$(use_enable gles2 glesv2)
		$(use_enable glib gobject)
		$(use_enable opengl gl)
		$(use_enable static-libs static)
		$(use_enable svg)
		$(use_enable utils interpreter)
		$(use_enable utils script)
		$(use_enable utils trace)
		$(use_enable valgrind)
		$(use_enable xcb)
		$(use_enable xcb xcb-shm)
		--enable-ft
		--enable-pdf
		--enable-png
		--enable-ps
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_install_all() {
	find "${ED}" -name "*.la" -delete || die
}
