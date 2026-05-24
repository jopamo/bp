# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1 pypi

DESCRIPTION="The uv build backend"
HOMEPAGE="https://pypi.org/project/uv/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="uv-build"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
