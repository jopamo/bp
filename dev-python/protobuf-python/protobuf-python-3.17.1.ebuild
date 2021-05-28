# Distributed under the terms of the GNU General Public License v2

EAPI="7"

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

python_prepare_all() {
	pushd "${WORKDIR}/protobuf-${PV}" > /dev/null || die
	eapply "${FILESDIR}/${PN}-3.13.0-google.protobuf.pyext._message.PyUnknownFieldRef.patch"
	eapply_user
	popd > /dev/null || die

	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=(--cpp_implementation)
}

python_test() {
	esetup.py test
}

python_install_all() {
	distutils-r1_python_install_all

	find "${D}" -name "*.pth" -type f -delete || die
}
