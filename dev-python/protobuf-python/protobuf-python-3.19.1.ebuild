# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_SETUPTOOLS="bdepend"

inherit distutils-r1 flag-o-matic

DESCRIPTION="protobuf - Protocol Buffers - Python bindings"
HOMEPAGE="https://developers.google.com/protocol-buffers/"
SRC_URI="https://github.com/protocolbuffers/protobuf/archive/v${PV}.tar.gz -> protobuf-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="${PYTHON_DEPS}
	~lib-dev/protobuf-${PV}
	dev-python/six[${PYTHON_USEDEP}]"
DEPEND="${PYTHON_DEPS}
	~lib-dev/protobuf-${PV}"

S="${WORKDIR}/protobuf-${PV}/python"

filter-flags -Wl,-z,defs

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all

	find "${D}" -name "*.pth" -type f -delete || die
}
