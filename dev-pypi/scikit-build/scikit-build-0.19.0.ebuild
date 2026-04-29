# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Improved build system generator for Python C/C++/Fortran/Cython extensions"
HOMEPAGE="https://github.com/scikit-build/scikit-build"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/de/33/7926e05f15c4c06f6bbdf2c5ad0bb67cb93881604c49c47409837cf28e7c/scikit_build-0.19.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/scikit_build-0.19.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/distro
	dev-pypi/packaging
	dev-pypi/setuptools
	dev-pypi/wheel
"
# lockstep-pypi-deps: end
