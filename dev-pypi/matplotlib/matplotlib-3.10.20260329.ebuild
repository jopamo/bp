# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Python plotting package"
HOMEPAGE="https://matplotlib.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://github.com/matplotlib/matplotlib/archive/51c85f72d6b37cb1d83c56774aa7260a1cbbf5e3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/matplotlib-51c85f72d6b37cb1d83c56774aa7260a1cbbf5e3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/contourpy
	dev-pypi/cycler
	dev-pypi/fonttools
	dev-pypi/kiwisolver
	dev-pypi/numpy
	dev-pypi/packaging
	dev-pypi/pillow
	dev-pypi/pyparsing
	dev-pypi/python-dateutil
"
# lockstep-pypi-deps: end
