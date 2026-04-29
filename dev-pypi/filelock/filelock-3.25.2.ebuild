# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A platform independent file lock."
HOMEPAGE="https://github.com/tox-dev/py-filelock"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/94/b8/00651a0f559862f3bb7d6f7477b192afe3f583cc5e26403b44e59a55ab34/filelock-3.25.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/filelock-3.25.2"
