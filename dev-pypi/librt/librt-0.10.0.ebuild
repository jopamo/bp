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

SRC_URI="https://files.pythonhosted.org/packages/39/cb/c1945e506893b5b8577fb45a60c80e3ffe4a82092a04a6f29b0b951d9a24/librt-0.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/librt-0.10.0"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
