# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"

SNAPSHOT=e4a31f024b6158aaaf55a43502f574d5f5d1c894
SRC_URI="https://github.com/pnggroup/libpng/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/libpng-${SNAPSHOT}"

LICENSE="libpng"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs"

DEPEND="
	lib-core/zlib
	app-compression/xz-utils
"

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
