# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SNAPSHOT=be81ebe1a45c2da3c5788485cd55408fe2e328df
SRC_URI="https://github.com/pnggroup/libpng/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="libpng"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs"

DEPEND="
	lib-core/zlib
	app-compression/xz-utils
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable static-libs static)
	)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
