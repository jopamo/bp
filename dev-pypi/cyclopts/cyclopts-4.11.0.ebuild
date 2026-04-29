# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="cyclopts"
DESCRIPTION="Intuitive, easy CLIs based on type hints."
HOMEPAGE="https://github.com/BrianPugh/cyclopts"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/docstring-parser
	dev-pypi/rich
	dev-pypi/rich-rst
"
# lockstep-pypi-deps: end
