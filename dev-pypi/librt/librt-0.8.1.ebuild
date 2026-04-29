# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Mypyc runtime library"
HOMEPAGE="https://github.com/mypyc/librt"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/56/9c/b4b0c54d84da4a94b37bd44151e46d5e583c9534c7e02250b961b1b6d8a8/librt-0.8.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/librt-0.8.1"
