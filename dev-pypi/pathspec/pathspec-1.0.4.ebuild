# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Utility library for gitignore style pattern matching of file paths."
HOMEPAGE="https://pypi.org/project/pathspec/"
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/fa/36/e27608899f9b8d4dff0617b2d9ab17ca5608956ca44461ac14ac48b44015/pathspec-1.0.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pathspec-1.0.4"
