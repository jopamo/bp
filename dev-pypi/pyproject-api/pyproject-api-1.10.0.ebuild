# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="API to interact with the python pyproject.toml based projects"
HOMEPAGE="https://pyproject-api.readthedocs.io"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/45/7b/c0e1333b61d41c69e59e5366e727b18c4992688caf0de1be10b3e5265f6b/pyproject_api-1.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pyproject_api-1.10.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
