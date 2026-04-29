# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Fundamental algorithms for scientific computing in Python"
HOMEPAGE="https://scipy.org/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/7a/97/5a3609c4f8d58b039179648e62dd220f89864f56f7357f5d4f45c29eb2cc/scipy-1.17.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/scipy-1.17.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/numpy
"
# lockstep-pypi-deps: end
