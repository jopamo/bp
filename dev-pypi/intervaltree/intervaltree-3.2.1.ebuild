# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Editable interval tree data structure for Python 2 and 3"
HOMEPAGE="https://github.com/chaimleib/intervaltree"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/53/c3/b2afa612aa0373f3e6bb190e6de35f293b307d1537f109e3e25dbfcdf212/intervaltree-3.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/intervaltree-3.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/sortedcontainers
"
# lockstep-pypi-deps: end
