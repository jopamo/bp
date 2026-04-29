# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="scikit-build-core"

inherit distutils-r1

DESCRIPTION="Seamless operability between C++11 and Python"
HOMEPAGE="https://github.com/pybind/pybind11"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2f/7b/a6d8dcb83c457e24a9df1e4d8fd5fb8034d4bbc62f3c324681e8a9ba57c2/pybind11-3.0.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pybind11-3.0.1"
