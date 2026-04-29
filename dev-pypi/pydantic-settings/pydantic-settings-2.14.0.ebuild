# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="pydantic-settings"
DESCRIPTION="Settings management using Pydantic"
HOMEPAGE="https://github.com/pydantic/pydantic-settings"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pydantic
	dev-pypi/python-dotenv
	dev-pypi/typing-inspection
"
# lockstep-pypi-deps: end
