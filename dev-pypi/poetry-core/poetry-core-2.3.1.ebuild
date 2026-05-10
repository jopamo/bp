# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="standalone"

inherit distutils-r1 pypi

DESCRIPTION="Poetry PEP 517 build backend"
HOMEPAGE="
	https://github.com/python-poetry/poetry-core/
	https://pypi.org/project/poetry-core/
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/fastjsonschema
	dev-pypi/lark
	dev-pypi/packaging
"
# lockstep-pypi-deps: end
RDEPEND="
	>=dev-pypi/fastjsonschema-2.21.2[${PYTHON_USEDEP}]
	>=dev-pypi/lark-1.3.1[${PYTHON_USEDEP}]
	>=dev-pypi/packaging-26.2[${PYTHON_USEDEP}]
"
