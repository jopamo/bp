# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Unbearably fast near-real-time pure-Python runtime-static type-checker."
HOMEPAGE="https://pypi.org/project/beartype/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c7/94/1009e248bbfbab11397abca7193bea6626806be9a327d399810d523a07cb/beartype-0.22.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/beartype-0.22.9"
