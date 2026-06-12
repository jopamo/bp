# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Poetry PEP 517 Build Backend"
HOMEPAGE="https://github.com/python-poetry/poetry-core"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b2/f2/fa88c58efb9a737c7e0e40e470edd0973fe33f0f277d24dcf17454b50974/poetry_core-2.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/poetry_core-2.4.1"
