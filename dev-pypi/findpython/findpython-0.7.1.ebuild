# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="A utility to find python versions on your system"
HOMEPAGE="https://github.com/frostming/findpython"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d1/83/2fec4c27a2806bd6de061fc3823dea72a9b41305c5baaf9ca720ce2afdc9/findpython-0.7.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/findpython-0.7.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/platformdirs
"
# lockstep-pypi-deps: end
