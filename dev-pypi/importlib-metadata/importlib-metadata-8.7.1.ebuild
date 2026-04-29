# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Read metadata from Python packages"
HOMEPAGE="https://pypi.org/project/importlib-metadata/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f3/49/3b30cad09e7771a4982d9975a8cbf64f00d4a1ececb53297f1d9a7be1b10/importlib_metadata-8.7.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/importlib_metadata-8.7.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/zipp
"
# lockstep-pypi-deps: end
