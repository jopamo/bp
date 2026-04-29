# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="tifffile"
DESCRIPTION="Read and write TIFF files"
HOMEPAGE="https://www.cgohlke.com"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
"
# lockstep-pypi-deps: end
