# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="The missing async toolbox"
HOMEPAGE="https://pypi.org/project/asyncstdlib/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3a/66/7b76f2b48afc5c8b4648500a4ff9869f83528e3d601a19de51da18b5e8a5/asyncstdlib-3.14.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/asyncstdlib-3.14.0"
