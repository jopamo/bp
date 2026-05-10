# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="better multiprocessing and multithreading in Python"
HOMEPAGE="https://github.com/uqfoundation/multiprocess"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a2/f2/e783ac7f2aeeed14e9e12801f22529cc7e6b7ab80928d6dcce4e9f00922d/multiprocess-0.70.19.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/multiprocess-0.70.19"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/dill
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
