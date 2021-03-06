# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

TOML_TEST_VER="280497fa5f12e43d7233aed0d74e07ca61ef176b"

DESCRIPTION="Python library for handling TOML files"
HOMEPAGE="https://github.com/uiri/toml"
SRC_URI="https://github.com/uiri/${PN}/archive/${PV}.tar.gz -> ${P}-1.tar.gz
	test? ( https://github.com/BurntSushi/toml-test/archive/${TOML_TEST_VER}.tar.gz -> toml-test-${TOML_TEST_VER}.tar.gz )"
IUSE="test"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

BDEPEND="test? ( dev-python/numpy[${PYTHON_USEDEP}] )"

DOCS=( README.rst )

distutils_enable_tests pytest

python_prepare_all() {
	if use test; then
		mv "${WORKDIR}/toml-test-${TOML_TEST_VER#v}" "${S}/toml-test" || die
	fi

	distutils-r1_python_prepare_all
}
