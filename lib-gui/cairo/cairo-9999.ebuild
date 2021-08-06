# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic autotools

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="https://www.cairographics.org"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://gitlab.freedesktop.org/cairo/cairo.git"
else
	SRC_URI="https://www.cairographics.org/releases/${P}.tar.xz
	    https://cairographics.org/snapshots/${P}.tar.xz"
	KEYWORDS="amd64 arm64"
fi

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"

IUSE="X debug doc +glib static-libs +svg valgrind xcb"

RESTRICT="test"

RDEPEND="
	>=lib-media/fontconfig-2.10.92
	>=lib-media/freetype-2.5.0.1:2
	>=lib-media/libpng-1.6.10:0=
	>=lib-sys/zlib-1.2.8-r1
	>=lib-gui/pixman-0.32.4
	glib? ( >=lib-dev/glib-2.34.3:2 )
	X? (
		>=x11-live-libs/libXrender-0.9.8
		>=x11-live-libs/libXext-1.3.2
		>=x11-live-libs/libX11-1.6.2
	)
	xcb? ( lib-gui/libxcb )"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	>=sys-devel/libtool-2
	X? ( x11-live-misc/xorgproto )"

PATCHES=(
	"${FILESDIR}"/${PN}-1.12.18-disable-test-suite.patch
	"${FILESDIR}"/${PN}-respect-fontconfig.patch
)

filter-flags -Wl,-z,defs

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

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-dependency-tracking
		$(use_with X x)
		$(use_enable X tee)
		$(use_enable X xlib)
		$(use_enable X xlib-xrender)
		$(use_enable debug test-surfaces)
		$(use_enable doc gtk-doc)
		$(use_enable glib gobject)
		--disable-gl
		$(use_enable static-libs static)
		$(use_enable svg)
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
