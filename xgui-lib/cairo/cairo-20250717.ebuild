# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson

DESCRIPTION="A vector graphics library with cross-device output support"
HOMEPAGE="https://www.cairographics.org"
SNAPSHOT=04656d7450e229622546fd2b11496aa58c44181d
SRC_URI="https://gitlab.freedesktop.org/cairo/cairo/-/archive/${SNAPSHOT}/cairo-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/cairo-${SNAPSHOT}"

LICENSE="|| ( LGPL-2.1 MPL-1.1 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="X debug glib static-libs svg valgrind xcb"

RESTRICT="test"

DEPEND="
	fonts/fontconfig
	lib-core/zlib
	xgui-lib/pixman
	xgui-lib/freetype
	xmedia-lib/libpng
	glib? ( lib-util/glib )
	X? (
		xgui-lib/libXrender
		xgui-lib/libXext
		xgui-lib/libX11
	)
	xcb? ( xgui-lib/libxcb )
"
BDEPEND="
	app-dev/pkgconf
	app-build/libtool
	X? ( xgui-tools/xorgproto )
"

PATCHES=(
	"${FILESDIR}"/cairo-respect-fontconfig.patch
)


src_prepare() {
	default

	filter-flags -Wl,-z,defs
	# tests and perf tools require X, bug #483574
	if ! use X; then
		sed -e '/^SUBDIRS/ s#boilerplate test perf# #' -i Makefile.am || die
	fi

	touch boilerplate/Makefile.am.features
	touch src/Makefile.am.features
	touch ChangeLog
}
