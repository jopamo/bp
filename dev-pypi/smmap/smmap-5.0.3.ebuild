# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A pure Python implementation of a sliding window memory map manager"
HOMEPAGE="https://github.com/gitpython-developers/smmap"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1f/ea/49c993d6dfdd7338c9b1000a0f36817ed7ec84577ae2e52f890d1a4ff909/smmap-5.0.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/smmap-5.0.3"
