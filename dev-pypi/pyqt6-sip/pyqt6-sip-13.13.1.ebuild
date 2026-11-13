# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND=""
# lockstep-pypi-deps: end

DESCRIPTION="SIP runtime module for PyQt6"
HOMEPAGE="https://www.riverbankcomputing.com/software/sip/"
SRC_URI="https://files.pythonhosted.org/packages/03/da/164fe6759acbd04c4523a9471c4d11f4b3c744182cb7bbd87faf249ce172/pyqt6_sip-13.13.1.tar.gz"
S="${WORKDIR}/pyqt6_sip-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
