# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"

SNAPSHOT=c1cc0f3f4c3d4abd11ca68c59446a29ff6f95003
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
