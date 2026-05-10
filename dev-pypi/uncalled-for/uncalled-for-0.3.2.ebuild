# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Async dependency injection for Python functions"
HOMEPAGE="https://pypi.org/project/uncalled-for/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b5/82/345cc927f7fbdae6065e7768759932fcc827fc20b29b45dfbafa2f1f7da4/uncalled_for-0.3.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uncalled_for-0.3.2"

BDEPEND="
	dev-pypi/hatch-vcs[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
