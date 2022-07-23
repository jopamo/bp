# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic libtool python-any-r1

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/HarfBuzz"
SRC_URI="https://github.com/harfbuzz/harfbuzz/releases/download/${PV}/${P}.tar.xz"

LICENSE="Old-MIT ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+cairo debug +glib +introspection static-libs test +truetype"

REQUIRED_USE="introspection? ( glib )"

DEPEND="
	fonts/fontconfig
	cairo? ( xgui-live-lib/cairo )
	glib? ( lib-live/glib )
	introspection? ( lib-live/gobject-introspection )
	truetype? ( xgui-misc/freetype )
"
BDEPEND="
	app-dev/gtk-doc-am
	app-dev/pkgconf
	test? ( ${PYTHON_DEPS} )
"

pkg_setup() {
	use test && python-any-r1_pkg_setup

	if ! use debug ; then
		append-cppflags -DHB_NDEBUG
	fi
}

src_prepare() {
	default
	xdg_environment_reset
}

src_configure() {
	local myconf=(
		$(use_enable introspection)
		$(use_enable static-libs static)
		$(use_with cairo)
		$(use_with glib)
		$(use_with introspection gobject)
		$(use_with truetype freetype)
		--without-coretext
		--without-icu
		--without-uniscribe
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
