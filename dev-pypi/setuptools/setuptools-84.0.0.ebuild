# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Most extensible Python build backend with support for C/C++ extension modules"
HOMEPAGE="https://pypi.org/project/setuptools/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6d/44/f5da03a8ef95d369145c5bb53050e7877c9f3d312e128605fd9504829143/setuptools-84.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools-84.0.0"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
