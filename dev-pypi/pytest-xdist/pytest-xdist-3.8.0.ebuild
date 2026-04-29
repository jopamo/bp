# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="pytest xdist plugin for distributed testing, most importantly across multiple CPUs"
HOMEPAGE="https://github.com/pytest-dev/pytest-xdist"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/78/b4/439b179d1ff526791eb921115fca8e44e596a13efeda518b9d845a619450/pytest_xdist-3.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest_xdist-3.8.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/execnet
	dev-pypi/pytest
"
# lockstep-pypi-deps: end
