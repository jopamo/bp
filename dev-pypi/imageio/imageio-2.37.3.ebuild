# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="imageio"
DESCRIPTION="Read and write images and video across all major formats. Supports scientific and volumetric data."
HOMEPAGE="https://github.com/imageio/imageio"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
	dev-pypi/pillow
"
# lockstep-pypi-deps: end
