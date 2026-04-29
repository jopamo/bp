# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A tool for generating OIDC identities"
HOMEPAGE="https://pypi.org/project/id/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6d/04/c2156091427636080787aac190019dc64096e56a23b7364d3c1764ee3a06/id-1.6.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/id-1.6.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/urllib3
"
# lockstep-pypi-deps: end
