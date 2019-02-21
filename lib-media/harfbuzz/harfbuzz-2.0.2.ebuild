# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_7 )

inherit flag-o-matic libtool python-any-r1 xdg-utils autotools

DESCRIPTION="An OpenType text shaping engine"
HOMEPAGE="https://www.freedesktop.org/wiki/Software/HarfBuzz"

if [[ ${PV} = 9999 ]] ; then
	EGIT_REPO_URI="https://anongit.freedesktop.org/git/harfbuzz.git"
	inherit git-r3 autotools
else
	SRC_URI="https://www.freedesktop.org/software/${PN}/release/${P}.tar.bz2"
fi

KEYWORDS="amd64 arm64"
LICENSE="Old-MIT ISC icu"
SLOT="0"

IUSE="+cairo debug fontconfig +glib icu +introspection static-libs test +truetype"
REQUIRED_USE="introspection? ( glib )"

RDEPEND="
	cairo? ( x11-libs/cairo:= )
	fontconfig? ( lib-media/fontconfig:1.0 )
	glib? ( >=lib-dev/glib-2.38:2 )
	icu? ( >=lib-dev/icu-51.2-r1:= )
	introspection? ( >=lib-dev/gobject-introspection-1.34:= )
	truetype? ( >=lib-media/freetype-2.5.0.1:2= )
"
DEPEND="${RDEPEND}
	dev-util/gtk-doc-am
	dev-util/pkgconfig
	test? ( ${PYTHON_DEPS} )
"
# eautoreconf requires gobject-introspection-common
# ragel needed if regenerating *.hh files from *.rl
if [[ ${PV} = 9999 ]] ; then
	DEPEND+="
		>=lib-dev/gobject-introspection-common-1.34
		dev-util/ragel
	"
fi

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
	local myeconfargs=(
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
	ECONF_SOURCE="${S}" econf "${myeconfargs[@]}"
}
