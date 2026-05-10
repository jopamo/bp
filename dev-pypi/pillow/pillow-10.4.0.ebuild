# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python Imaging Library (Fork)"
HOMEPAGE="https://python-pillow.org"
LICENSE="HPND"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/cd/74/ad3d526f3bf7b6d3f408b73fde271ec69dfac8b81341a318ce825f2b3812/pillow-10.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pillow-10.4.0"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
