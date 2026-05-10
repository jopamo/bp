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

SRC_URI="https://files.pythonhosted.org/packages/51/40/52d9961c488d9a45c7ed26f76b50e70f0d562d7fafd936121303cc7500ad/unicorn-2.1.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/unicorn-2.1.3"

BDEPEND="
	dev-pypi/build[${PYTHON_USEDEP}]
	dev-pypi/setuptools-scm[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
