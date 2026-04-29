# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="editorconfig"
DESCRIPTION="EditorConfig File Locator and Interpreter for Python"
HOMEPAGE="https://editorconfig.org/"
LICENSE="PSF-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
