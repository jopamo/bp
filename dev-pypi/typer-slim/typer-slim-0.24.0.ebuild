# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1 pypi

PYPI_PN="typer-slim"
DESCRIPTION="Typer, build great CLIs. Easy to code. Based on Python type hints."
HOMEPAGE="https://github.com/fastapi/typer"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/typer
"
# lockstep-pypi-deps: end
