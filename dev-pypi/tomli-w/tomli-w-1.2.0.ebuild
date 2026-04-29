# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="tomli-w"
DESCRIPTION="A lil' TOML writer"
HOMEPAGE="https://github.com/hukkin/tomli-w"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
