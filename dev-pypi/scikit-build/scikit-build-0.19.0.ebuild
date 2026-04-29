# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="scikit-build"
DESCRIPTION="Improved build system generator for Python C/C++/Fortran/Cython extensions"
HOMEPAGE="https://github.com/scikit-build/scikit-build"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/distro
	dev-pypi/packaging
	dev-pypi/setuptools
	dev-pypi/wheel
"
# lockstep-pypi-deps: end
