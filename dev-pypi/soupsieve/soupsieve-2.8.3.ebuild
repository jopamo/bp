# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A modern CSS selector implementation for Beautiful Soup."
HOMEPAGE="https://github.com/facelessuser/soupsieve"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/7b/ae/2d9c981590ed9999a0d91755b47fc74f74de286b0f5cee14c9269041e6c4/soupsieve-2.8.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/soupsieve-2.8.3"
