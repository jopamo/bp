# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Happy Eyeballs for asyncio"
HOMEPAGE="https://pypi.org/project/aiohappyeyeballs/"
LICENSE="PSF-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/26/30/f84a107a9c4331c14b2b586036f40965c128aa4fee4dda5d3d51cb14ad54/aiohappyeyeballs-2.6.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/aiohappyeyeballs-2.6.1"
