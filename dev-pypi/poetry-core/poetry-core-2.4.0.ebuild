# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Poetry PEP 517 Build Backend"
HOMEPAGE="https://github.com/python-poetry/poetry-core"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b0/97/f7bb55470bb7890d9b3d3f9fa761083d5c9a6838b17c94a41bf2939f89ef/poetry_core-2.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/poetry_core-2.4.0"
