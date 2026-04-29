# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1 pypi

PYPI_PN="scikit-image"
DESCRIPTION="Image processing in Python"
HOMEPAGE="https://scikit-image.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/imageio
	dev-pypi/lazy-loader
	dev-pypi/networkx
	dev-pypi/numpy
	dev-pypi/packaging
	dev-pypi/pillow
	dev-pypi/scipy
	dev-pypi/tifffile
"
# lockstep-pypi-deps: end
