# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Capstone disassembly engine"
HOMEPAGE="https://www.capstone-engine.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/39/01/6516910f546fbb996068207b9dd0229b14bc8dae223114d5e0e27d3cad11/capstone-5.0.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/capstone-5.0.9"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
