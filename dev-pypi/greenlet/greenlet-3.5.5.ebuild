# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Lightweight in-process concurrent programming"
HOMEPAGE="https://greenlet.readthedocs.io"
LICENSE="MIT PSF-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/0b/d8/7cc97c142388aef03f622e001c572c4f84e9252a439549d483f555771970/greenlet-3.5.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/greenlet-3.5.5"

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
