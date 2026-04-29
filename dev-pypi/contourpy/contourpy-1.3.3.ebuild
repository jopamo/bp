# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Python library for calculating contours of 2D quadrilateral grids"
HOMEPAGE="https://github.com/contourpy/contourpy"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/58/01/1253e6698a07380cd31a736d248a3f2a50a7c88779a1813da27503cadc2a/contourpy-1.3.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/contourpy-1.3.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
"
# lockstep-pypi-deps: end
