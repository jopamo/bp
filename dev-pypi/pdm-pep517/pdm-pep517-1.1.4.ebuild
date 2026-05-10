# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A PEP 517 backend for PDM that supports PEP 621 metadata"
HOMEPAGE="https://pdm.fming.dev"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/43/42/5c8818b70fc4b25c99e56aeeb3484ede076114c8a0772675b44a3b7891cc/pdm-pep517-1.1.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pdm-pep517-1.1.4"
