# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="ropgadget"
DESCRIPTION="This tool lets you search your gadgets on your binaries to facilitate your ROP exploitation."
HOMEPAGE="https://github.com/JonathanSalwan/ROPgadget"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/capstone
"
# lockstep-pypi-deps: end
