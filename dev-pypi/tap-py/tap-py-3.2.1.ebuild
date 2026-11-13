# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Test Anything Protocol (TAP) tools"
HOMEPAGE="https://pypi.org/project/tap-py/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/37/d0/28b0c6c7fe464f70664f123e9f64f36acaf92767af98c1a82df6e2b49f41/tap_py-3.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tap_py-3.2.1"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
