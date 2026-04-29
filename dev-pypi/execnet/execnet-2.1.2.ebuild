# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="execnet: rapid multi-Python deployment"
HOMEPAGE="https://execnet.readthedocs.io/en/latest/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/bf/89/780e11f9588d9e7128a3f87788354c7946a9cbb1401ad38a48c4db9a4f07/execnet-2.1.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/execnet-2.1.2"
