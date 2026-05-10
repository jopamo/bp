# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="ANSI color formatting for output in terminal"
HOMEPAGE="https://github.com/termcolor/termcolor"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/46/79/cf31d7a93a8fdc6aa0fbb665be84426a8c5a557d9240b6239e9e11e35fc5/termcolor-3.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/termcolor-3.3.0"

BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
