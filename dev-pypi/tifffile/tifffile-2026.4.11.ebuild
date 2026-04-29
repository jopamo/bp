# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Read and write TIFF files"
HOMEPAGE="https://www.cgohlke.com"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d7/4a/e687f5957fead200faad58dbf9c9431a2bbb118040e96f5fb8a55f7ebc50/tifffile-2026.4.11.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tifffile-2026.4.11"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
"
# lockstep-pypi-deps: end
