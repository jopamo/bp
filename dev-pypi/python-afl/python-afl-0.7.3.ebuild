# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="American Fuzzy Lop fork server and instrumentation for pure-Python code"
HOMEPAGE="http://jwilk.net/software/python-afl"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9d/47/12d68610f99e2d60e31b6031f9d9ebeb38be2f828440052a29a0933dfdb0/python-afl-0.7.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python-afl-0.7.3"

BDEPEND="
	dev-pypi/cython[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
