# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Python interpreter discovery"
HOMEPAGE="https://github.com/tox-dev/python-discovery"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/de/ef/3bae0e537cfe91e8431efcba4434463d2c5a65f5a89edd47c6cf2f03c55f/python_discovery-1.2.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python_discovery-1.2.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/filelock
	dev-pypi/platformdirs
"
# lockstep-pypi-deps: end
