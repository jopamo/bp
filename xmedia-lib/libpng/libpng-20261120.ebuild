# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )

inherit autotools python-any-r1 qa-policy

DESCRIPTION="Portable Network Graphics library"
HOMEPAGE="http://www.libpng.org/"
SNAPSHOT=73a6865278d33ebfb4fe957718d2eaf8316c4ec7
SRC_URI="https://github.com/pnggroup/libpng/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="libpng"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="keep-la static-libs test"

DEPEND="
	lib-core/zlib
	app-compression/xz-utils
"
BDEPEND="test? ( ${PYTHON_DEPS} )"

PATCHES=( "${FILESDIR}/libpng-test-roundtrip-contents.patch" )

pkg_setup() {
	if use test; then
		python-any-r1_pkg_setup
	fi
}

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

src_test() {
	local -x PNG_ROUNDTRIP_PYTHON="${EPYTHON}"
	local -x PNG_ROUNDTRIP_COMPARE="${FILESDIR}/png-roundtrip-contents.py"
	default
}

src_install() {
	default
	qa-policy-install

	if ! use keep-la; then
		find "${ED}" -name '*.la' -delete || die
	fi
}
