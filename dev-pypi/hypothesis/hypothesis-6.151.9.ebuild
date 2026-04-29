# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="The property-based testing library for Python"
HOMEPAGE="https://hypothesis.works"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/19/e1/ef365ff480903b929d28e057f57b76cae51a30375943e33374ec9a165d9c/hypothesis-6.151.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hypothesis-6.151.9"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/sortedcontainers
"
# lockstep-pypi-deps: end
