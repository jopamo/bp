# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="pyproject-hooks"
DESCRIPTION="Wrappers to call pyproject.toml-based build backend hooks."
HOMEPAGE="https://pypi.org/project/pyproject-hooks/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
