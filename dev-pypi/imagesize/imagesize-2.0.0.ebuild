# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Get image size from headers (BMP/PNG/JPEG/JPEG2000/GIF/TIFF/SVG/Netpbm/WebP/AVIF/HEIC/HEIF)"
HOMEPAGE="https://github.com/shibukawa/imagesize_py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/6c/e6/7bf14eeb8f8b7251141944835abd42eb20a658d89084b7e1f3e5fe394090/imagesize-2.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/imagesize-2.0.0"
