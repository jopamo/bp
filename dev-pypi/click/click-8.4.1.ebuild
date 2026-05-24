# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

DESCRIPTION="Composable command line interface toolkit"
HOMEPAGE="https://pypi.org/project/click/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="click"

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
"
