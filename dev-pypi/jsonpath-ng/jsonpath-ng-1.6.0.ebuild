# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A final implementation of JSONPath for Python that aims to be standard compliant, including arithmetic and binary comparison operators and providing clear AST for metaprogramming."
HOMEPAGE="https://github.com/h2non/jsonpath-ng"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b2/f3/37dfe7f3e4f5e21f66f301bc82a6aaca23fed8c435514a699f0af283c9e7/jsonpath-ng-1.6.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jsonpath-ng-1.6.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/ply
"
# lockstep-pypi-deps: end
