# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Read and write images and video across all major formats. Supports scientific and volumetric data."
HOMEPAGE="https://github.com/imageio/imageio"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b1/84/93bcd1300216ea50811cee96873b84a1bebf8d0489ffaf7f2a3756bab866/imageio-2.37.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/imageio-2.37.3"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
	dev-pypi/pillow
"
# lockstep-pypi-deps: end
