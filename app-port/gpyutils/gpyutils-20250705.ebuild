# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="Utitilies for maintaining Python packages"
HOMEPAGE="https://pypi.org/project/gpyutils/"
SNAPSHOT=68aa2dadf2f70f560f6bb5ab92b25bcaf6e74678
SRC_URI="https://github.com/projg2/gpyutils/archive/${SNAPSHOT}.tar.gz -> gpyutils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gpyutils-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-portage/gentoopm-0.3.2[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
