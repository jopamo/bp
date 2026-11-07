# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Declarative CLI argument parser."
HOMEPAGE="https://pypi.org/project/cappa/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1d/54/eef760748f8249ce4ca699688317422a87d3d997d621464a24e1a6b8d128/cappa-0.33.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cappa-0.33.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/rich
	dev-pypi/type-lens
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
