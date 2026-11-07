# Distributed under the terms of the GNU General Public License v2

PYTHON_COMPAT=( python3_13 )
DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=setuptools

inherit distutils-r1

DESCRIPTION="SIP runtime module for PyQt6"
HOMEPAGE="https://www.riverbankcomputing.com/software/sip/"
SRC_URI="https://files.pythonhosted.org/packages/78/35/bed43ff7cf040ced6b62a17b272abecb94914755284b54e8d06844e1ed23/pyqt6_sip-13.13.0.tar.gz"
S="${WORKDIR}/pyqt6_sip-${PV}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
