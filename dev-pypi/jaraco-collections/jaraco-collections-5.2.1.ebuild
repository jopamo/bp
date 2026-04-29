# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Collection objects similar to those in stdlib by jaraco"
HOMEPAGE="https://pypi.org/project/jaraco-collections/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/fa/d2/751000cf702676dbb78f97728f4d52b029e817e2b3c94088dfe5c70ff46d/jaraco_collections-5.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jaraco_collections-5.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-text
"
# lockstep-pypi-deps: end
