# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/setuptools
"
# lockstep-pypi-deps: end

DESCRIPTION="Python bindings generator for C and C++ libraries"
HOMEPAGE="https://github.com/Python-SIP/sip"
SRC_URI="https://files.pythonhosted.org/packages/cd/65/6bfe13637ee9adfc07c4ee8501aa3e4e2f0555e6163a6cba80f70698a0a0/sip-6.17.3.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-pypi/packaging-24.2[${PYTHON_USEDEP}]
	>=dev-pypi/setuptools-75.8.1[${PYTHON_USEDEP}]
"
BDEPEND=">=dev-pypi/setuptools-scm-8[${PYTHON_USEDEP}]"
