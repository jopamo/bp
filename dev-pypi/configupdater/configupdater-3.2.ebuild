# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Parser like ConfigParser but for updating configuration files"
HOMEPAGE="https://github.com/pyscaffold/configupdater"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2b/f4/603bd8a65e040b23d25b5843836297b0f4e430f509d8ed2ef8f072fb4127/ConfigUpdater-3.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ConfigUpdater-3.2"
