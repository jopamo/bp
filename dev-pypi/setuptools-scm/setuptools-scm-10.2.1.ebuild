# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="the blessed package to manage your versions by scm tags"
HOMEPAGE="https://pypi.org/project/setuptools-scm/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/5d/b1/d0b97ffd2856a7d19c63024a89fb84813cb9d2ed7fa8fdbedf9e2f13a9ab/setuptools_scm-10.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools_scm-10.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/setuptools
	dev-pypi/vcs-versioning
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/vcs-versioning[${PYTHON_USEDEP}]
"
