# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic libtool python-any-r1 autotools

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/HarfBuzz"
SRC_URI="https://github.com/harfbuzz/harfbuzz/releases/download/${PV}/${P}.tar.xz"

LICENSE="Old-MIT ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+cairo debug +glib +introspection static-libs test +truetype"

REQUIRED_USE="introspection? ( glib )"

DEPEND="
	cairo? ( xgui-live-lib/cairo )
	fonts/fontconfig
	lib-dev/fribidi
	glib? ( lib-live/glib )
	introspection? ( lib-live/gobject-introspection )
	truetype? ( xgui-misc/freetype )
"
BDEPEND="
	dev-util/gtk-doc-am
	dev-util/pkgconf
	test? ( ${PYTHON_DEPS} )
"

append-cppflags -I/usr/include/fribidi
append-flags -lfribidi

pkg_setup() {
	use test && python-any-r1_pkg_setup
	if ! use debug ; then
		append-cppflags -DHB_NDEBUG
	fi
}

src_prepare() {
	default
	xdg_environment_reset
	eautoreconf
}

src_configure() {
	# harfbuzz-gobject only used for instrospection, bug #535852
	local myconf=(
		--without-coretext
		--without-uniscribe
		$(use_enable static-libs static)
		$(use_with cairo)
		$(use_with glib)
		$(use_with introspection gobject)
		--without-icu
		$(use_enable introspection)
		$(use_with truetype freetype)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
