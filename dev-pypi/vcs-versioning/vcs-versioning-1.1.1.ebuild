# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="the blessed package to manage your versions by vcs metadata"
HOMEPAGE="https://pypi.org/project/vcs-versioning/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/49/42/d97a7795055677961c63a1eef8e7b19d5968ed992ed3a70ab8eb012efad8/vcs_versioning-1.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/vcs_versioning-1.1.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
