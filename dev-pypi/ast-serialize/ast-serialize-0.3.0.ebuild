# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="Python bindings for mypy AST serialization"
HOMEPAGE="https://github.com/mypyc/ast_serialize"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a9/9d/912fefab0e30aee6a3af8a62bbea4a81b29afa4ba2c973d31170620a26de/ast_serialize-0.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ast_serialize-0.3.0"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
