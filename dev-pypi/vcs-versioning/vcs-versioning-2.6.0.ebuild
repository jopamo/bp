# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="the blessed package to manage your versions by vcs metadata"
HOMEPAGE="https://pypi.org/project/vcs-versioning/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ad/e7/2a691db7d076b75d099fdba1a14cd966931f2aeb591e77f6d22f15097326/vcs_versioning-2.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vcs_versioning-2.6.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/packaging[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
