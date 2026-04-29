# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="An XML Schema validator and decoder"
HOMEPAGE="https://github.com/sissaschool/xmlschema"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/da/c4/ef78a231be72349fd6677b989ff80e276ef62e28054c36c4fea3b4db9611/xmlschema-4.3.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/xmlschema-4.3.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/elementpath
"
# lockstep-pypi-deps: end
