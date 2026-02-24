# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="free lossless audio encoder and decoder"
HOMEPAGE="https://xiph.org/flac/"
SNAPSHOT=9d2388468e4565585b9756b04374394d68fb761d
SRC_URI="https://github.com/xiph/flac/archive/${SNAPSHOT}.tar.gz -> flac-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/flac-${SNAPSHOT}"

LICENSE="BSD GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="cpplibs debug ogg static-libs"

DEPEND="ogg? ( xmedia-lib/libogg )"

src_prepare() {
	use static-libs && lto-guarantee-fat

	touch config.rpath
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable cpplibs)
		$(use_enable debug)
		$(use_enable ogg)
		$(use_enable static-libs static)
		--disable-doxygen-docs
		--disable-examples
		--disable-programs
		--disable-rpath
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
