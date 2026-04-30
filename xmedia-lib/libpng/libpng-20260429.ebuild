# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SNAPSHOT=9ec49c2d56cec19107ddc458b648ce224c9697b3
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
	qa-policy-configure
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
	qa-policy-install

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
