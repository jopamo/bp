# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Build system for PyQt bindings"
HOMEPAGE="https://github.com/Python-PyQt/PyQt-builder"
SRC_URI="https://files.pythonhosted.org/packages/b3/e7/f80f910dc39d8f87fd567ac22bc0921ed1c8950c4e898c2f6b3868f2c4c9/pyqt_builder-1.21.0.tar.gz"
S="${WORKDIR}/pyqt_builder-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-pypi/packaging[${PYTHON_USEDEP}]
	>=dev-pypi/sip-6.7[${PYTHON_USEDEP}]
	<dev-pypi/sip-7[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-pypi/setuptools-scm-8[${PYTHON_USEDEP}]"
