# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="When they're not builtins, they're boltons."
HOMEPAGE="https://github.com/mahmoud/boltons"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/63/54/71a94d8e02da9a865587fb3fff100cb0fc7aa9f4d5ed9ed3a591216ddcc7/boltons-25.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/boltons-25.0.0"
