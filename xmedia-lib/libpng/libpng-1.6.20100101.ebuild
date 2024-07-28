# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"

SNAPSHOT=9343c6d3232b131c0295886a5949a673ee0a8c5f
SRC_URI="https://github.com/pnggroup/libpng/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pnggroup-${SNAPSHOT}"

LICENSE="libpng"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

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
