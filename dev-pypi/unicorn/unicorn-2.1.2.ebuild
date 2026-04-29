# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Unicorn CPU emulator engine"
HOMEPAGE="http://www.unicorn-engine.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/90/12/a10f01a3e1dafcd21e2eb0c0d99bb51d5bda1d3fee20047cb2a4b2de6285/unicorn-2.1.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unicorn-2.1.2"
