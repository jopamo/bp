# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="the blessed package to manage your versions by scm tags"
HOMEPAGE="https://pypi.org/project/setuptools-scm/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a5/b1/2a6a8ecd6f9e263754036a0b573360bdbd6873b595725e49e11139722041/setuptools_scm-10.0.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools_scm-10.0.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
	dev-pypi/setuptools
	dev-pypi/vcs-versioning
"
# lockstep-pypi-deps: end
