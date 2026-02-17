# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic meson python-any-r1 dot-a

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/HarfBuzz"
SRC_URI="https://github.com/harfbuzz/harfbuzz/releases/download/${PV}/${P}.tar.xz"

LICENSE="Old-MIT ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cairo debug glib introspection static-libs test truetype"

REQUIRED_USE="introspection? ( glib )"

DEPEND="
	fonts/fontconfig
	cairo? ( xgui-lib/cairo )
	glib? ( lib-core/glib )
	introspection? ( lib-dev/gobject-introspection )
	truetype? ( xgui-lib/freetype )
"
BDEPEND="
	app-dev/gtk-doc-am
	app-dev/pkgconf
	test? ( ${PYTHON_DEPS} )
"

pkg_setup() {
	filter-flags -fexceptions

	use test && python-any-r1_pkg_setup

	if ! use debug ; then
		append-cppflags -DHB_NDEBUG
	fi
}

src_configure() {
	use static-libs && lto-guarantee-fat

	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	use static-libs && strip-lto-bytecode
}
