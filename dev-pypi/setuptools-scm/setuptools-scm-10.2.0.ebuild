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

SRC_URI="https://files.pythonhosted.org/packages/61/fb/6b22ba201305ec33fa68c1419e984abe1aaee1b236a5e1186cc805738e95/setuptools_scm-10.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools_scm-10.2.0"

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
