# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-any-r1 flag-o-matic

DESCRIPTION="a fast cryptographic hash function"
HOMEPAGE="https://github.com/BLAKE3-team/BLAKE3"

SNAPSHOT=60ff2eafed63b29ed1622bb6330e640c22c683ff
SRC_URI="https://github.com/BLAKE3-team/BLAKE3/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/BLAKE3-${SNAPSHOT}/c"

LICENSE="|| ( CC0-1.0 Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="test"

RESTRICT="!test? ( test )"

BDEPEND="test? ( ${PYTHON_DEPS} )"

pkg_setup() {
	use test && python-any-r1_pkg_setup
}

src_prepare() {
	cp "${FILESDIR}/b3sum.c" "${S}/" || die "Failed to copy b3sum.c"
	cp "${FILESDIR}/meson.build" "${S}/" || die "Failed to copy meson.build"
	echo "option('build_static', type: 'boolean', value: false, description: 'Build static libraries')" > meson_options.txt

    default
}
