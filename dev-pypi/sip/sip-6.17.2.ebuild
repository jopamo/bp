# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="Python bindings generator for C and C++ libraries"
HOMEPAGE="https://github.com/Python-SIP/sip"
SRC_URI="https://files.pythonhosted.org/packages/c9/16/50c3758ae06375796dde6c94592f1bdd80a1ca709f776a09fd763682280d/sip-6.17.2.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/packaging-24.2[${PYTHON_USEDEP}]
	>=dev-pypi/setuptools-75.8.1[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-pypi/setuptools-scm-8[${PYTHON_USEDEP}]"
