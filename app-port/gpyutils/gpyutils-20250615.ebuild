# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit

inherit distutils-r1

DESCRIPTION="Utitilies for maintaining Python packages"
HOMEPAGE="https://pypi.org/project/gpyutils/"
SNAPSHOT=6fbffab740a3c1f64bed88c147f0390478220421
SRC_URI="https://github.com/projg2/gpyutils/archive/${SNAPSHOT}.tar.gz -> gpyutils-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gpyutils-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND=">=app-portage/gentoopm-0.3.2[${PYTHON_USEDEP}]"

distutils_enable_tests pytest
