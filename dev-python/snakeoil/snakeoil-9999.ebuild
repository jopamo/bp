# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

if [[ ${PV} == *9999 ]] ; then
	EGIT_REPO_URI="https://github.com/pkgcore/snakeoil.git"
	inherit git-r3
	KEYWORDS="amd64 arm64"
else
	SRC_URI="https://github.com/pkgcore/snakeoil/releases/download/v${PV}/${P}.tar.gz"
fi

DESCRIPTION="misc common functionality and useful optimizations"
HOMEPAGE="https://github.com/pkgcore/snakeoil"

LICENSE="BSD"
SLOT="0/1"
IUSE="test"

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
		dev-python/pytest-mock[${PYTHON_USEDEP}]
	)"
[[ ${PV} == 9999 ]] && DEPEND+=" dev-python/cython[${PYTHON_USEDEP}]"

python_prepare_all() {
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all
}
