# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

DESCRIPTION="Classes Without Boilerplate"
HOMEPAGE="https://pypi.org/project/attrs/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="attrs"

BDEPEND="
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
