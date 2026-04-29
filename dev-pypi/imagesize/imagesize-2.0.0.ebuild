# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="imagesize"
DESCRIPTION="Get image size from headers (BMP/PNG/JPEG/JPEG2000/GIF/TIFF/SVG/Netpbm/WebP/AVIF/HEIC/HEIF)"
HOMEPAGE="https://github.com/shibukawa/imagesize_py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
