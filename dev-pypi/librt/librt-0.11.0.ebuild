# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Mypyc runtime library"
HOMEPAGE="https://github.com/mypyc/librt"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/40/08/9e7f6b5d2b5bed6ad055cdd5925f192bb403a51280f86b56554d9d0699a2/librt-0.11.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/librt-0.11.0"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
