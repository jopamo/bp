# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"
PYPI_PN="pyproject_hooks"

inherit distutils-r1 pypi

DESCRIPTION="Wrappers to call pyproject.toml-based build backend hooks"
HOMEPAGE="
	https://github.com/pypa/pyproject-hooks/
	https://pyproject-hooks.readthedocs.io/
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
S="${WORKDIR}/${PYPI_PN}-${PV}"
