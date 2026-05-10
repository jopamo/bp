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

SRC_URI="https://files.pythonhosted.org/packages/cc/f0/35145a3c3baffeef55d4b8324caa33abaa8fa56ab345ecd4b2211d09163e/pybind11-3.0.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pybind11-3.0.4"

BDEPEND="
	dev-pypi/scikit-build-core[${PYTHON_USEDEP}]
"
