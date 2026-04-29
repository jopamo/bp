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

SRC_URI="https://files.pythonhosted.org/packages/8a/3f/4ca7dd7819bf8ff303aca39c3c60e5320e46e766ab7f7dd627d3b9c11bdf/librt-0.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/librt-0.8.0"
