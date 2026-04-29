# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Git Object Database"
HOMEPAGE="https://github.com/gitpython-developers/gitdb"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/72/94/63b0fc47eb32792c7ba1fe1b694daec9a63620db1e313033d18140c2320a/gitdb-4.0.12.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gitdb-4.0.12"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/smmap
"
# lockstep-pypi-deps: end
