# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Interfaces for Python"
HOMEPAGE="https://pypi.org/project/zope-interface/"
LICENSE="ZPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/08/dc/50550cfcbb2ea3cbca5f1d7ed05c8aa840f831a0f2d63aec0a953f7c590e/zope_interface-8.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zope_interface-8.5"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
