# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic libtool python-any-r1 autotools

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/HarfBuzz"
SRC_URI="https://github.com/harfbuzz/harfbuzz/releases/download/${PV}/${P}.tar.xz"

LICENSE="Old-MIT ISC icu"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+cairo debug fontconfig +glib icu +introspection static-libs test +truetype"

REQUIRED_USE="introspection? ( glib )"

RDEPEND="
	cairo? ( xgui-live-lib/cairo:= )
	fontconfig? ( xmedia-live-lib/fontconfig:1.0 )
	glib? ( >=lib-live/glib-2.38:2 )
	icu? ( >=lib-dev/icu-51.2-r1:= )
	introspection? ( >=lib-live/gobject-introspection-1.34:= )
	truetype? ( >=xmedia-live-lib/freetype-2.5.0.1:2= )
"
DEPEND="${RDEPEND}
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

	# failing test, https://bugs.freedesktop.org/show_bug.cgi?id=89190
	sed -e 's#tests/arabic-fallback-shaping.tests##' -i test/shaping/Makefile.in || die "sed failed"
}

src_configure() {
	# harfbuzz-gobject only used for instrospection, bug #535852
	local myconf=(
		--without-coretext
		--without-uniscribe
		$(use_enable static-libs static)
		$(use_with cairo)
		$(use_with fontconfig)
		$(use_with glib)
		$(use_with introspection gobject)
		$(use_with icu)
		$(use_enable introspection)
		$(use_with truetype freetype)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
