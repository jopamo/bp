# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Home directory fixtures"
HOMEPAGE="https://pypi.org/project/pytest-home/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dc/ce/5f9517c7cdcbb78637881ca4ddf32b0800b467d4b610b138d06dc5784863/pytest_home-0.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pytest_home-0.6.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pytest
"
# lockstep-pypi-deps: end
