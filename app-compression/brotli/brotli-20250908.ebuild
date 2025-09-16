# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_OPTIONAL="1"

inherit distutils-r1 cmake flag-o-matic

DESCRIPTION="Generic-purpose lossless compression algorithm"
HOMEPAGE="https://github.com/google/brotli"
SNAPSHOT=41a22f07f2ee09bdcf524de3646231d2c21933df
SRC_URI="https://github.com/google/brotli/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/brotli-${SNAPSHOT}

LICENSE="MIT python? ( Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python test"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# tests are currently broken, see https://github.com/google/brotli/issues/850
RESTRICT="test"

RDEPEND="python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}"

src_prepare() {
	filter-flags -Wl,-z,defs
	cmake_src_prepare
	use python && distutils-r1_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING="$(usex test)"
	)
	cmake_src_configure
	use python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && distutils-r1_src_compile
}

python_test() {
	esetup.py test || die
}

src_test() {
	cmake_src_test
	use python && distutils-r1_src_test
}

src_install() {
	cmake_src_install

	use python && distutils-r1_src_install
}
