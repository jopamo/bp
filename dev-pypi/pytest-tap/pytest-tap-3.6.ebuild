# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Test Anything Protocol (TAP) reporting plugin for pytest"
HOMEPAGE="https://pypi.org/project/pytest-tap/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/25/a6/46d219596f689e954396bfd9d0b46968f80ce49782b156dd2560d2a969ae/pytest_tap-3.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest_tap-3.6"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pytest
	dev-pypi/tap-py
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
