# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Image processing in Python"
HOMEPAGE="https://scikit-image.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/a1/b4/2528bb43c67d48053a7a649a9666432dc307d66ba02e3a6d5c40f46655df/scikit_image-0.26.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/scikit_image-0.26.0"

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
