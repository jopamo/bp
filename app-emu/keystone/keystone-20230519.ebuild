# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake distutils-r1 flag-o-matic

DESCRIPTION="Keystone assembler framework"
HOMEPAGE="https://github.com/keystone-engine/keystone"

SNAPSHOT=fb92f32391c6cced868252167509590319eeb58b
SRC_URI="https://github.com/keystone-engine/keystone/archive/${SNAPSHOT}.tar.gz -> keystone-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/keystone-${SNAPSHOT}"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="python"

DEPEND="
	dev-python/pefile
"

filter-flags -flto\*

src_prepare() {
	cmake_src_prepare
	use python && cd bindings/python && distutils-r1_src_prepare
}

src_configure() {
	cmake_src_configure
	use python && cd bindings/python && distutils-r1_src_configure
}

src_compile() {
	cmake_src_compile
	use python && cd bindings/python && distutils-r1_src_compile
}

python_test() {
	cd bindings/python && esetup.py test || die
}

src_test() {
	cmake_src_test
	use python && cd bindings/python && distutils-r1_src_test
}

src_install() {
	cmake_src_install
	use python && cd bindings/python && distutils-r1_src_install
}
