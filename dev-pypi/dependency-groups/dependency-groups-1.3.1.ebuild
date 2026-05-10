# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"
PYPI_PN="dependency_groups"

inherit distutils-r1 pypi

DESCRIPTION="A tool for resolving PEP 735 Dependency Group data"
HOMEPAGE="
	https://github.com/pypa/dependency-groups/
	https://pypi.org/project/dependency-groups/
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
S="${WORKDIR}/${PYPI_PN}-${PV}"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
RDEPEND="
	dev-pypi/packaging[${PYTHON_USEDEP}]
"
