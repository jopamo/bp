# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1

DESCRIPTION="Yet another URL library"
HOMEPAGE="https://github.com/aio-libs/yarl"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/31/33/ebe9e3d1f86c7a0b51094c0a146392045ca1631d2664889539dec8088a33/yarl-1.24.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/yarl-1.24.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/idna
	dev-pypi/multidict
	dev-pypi/propcache
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/expandvars[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
