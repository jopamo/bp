# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1 pypi

PYPI_PN="contourpy"
DESCRIPTION="Python library for calculating contours of 2D quadrilateral grids"
HOMEPAGE="https://github.com/contourpy/contourpy"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
"
# lockstep-pypi-deps: end
