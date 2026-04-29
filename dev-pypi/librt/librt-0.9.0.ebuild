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

SRC_URI="https://files.pythonhosted.org/packages/eb/6b/3d5c13fb3e3c4f43206c8f9dfed13778c2ed4f000bacaa0b7ce3c402a265/librt-0.9.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/librt-0.9.0"
