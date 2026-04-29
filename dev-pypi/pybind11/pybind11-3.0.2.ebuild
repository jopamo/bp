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

SRC_URI="https://files.pythonhosted.org/packages/a5/98/9118a0659646f1628c592ef9bb48e0056efa6bf27c951fd12a178e0136fb/pybind11-3.0.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pybind11-3.0.2"
