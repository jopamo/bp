# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A pytest plugin that allows multiple failures per test."
HOMEPAGE="https://pypi.org/project/pytest-check/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3b/50/b447f8e19cd9d952d19b8f37b14da9dec51cf31ddcc7af4a0b8478c1f4e1/pytest_check-3.0.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest_check-3.0.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/pytest
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
