# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Foreign Function Interface for Python calling C code."
HOMEPAGE="https://pypi.org/project/cffi/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/eb/56/b1ba7935a17738ae8453301356628e8147c79dbb825bcbc73dc7401f9846/cffi-2.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cffi-2.0.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pycparser
"
# lockstep-pypi-deps: end
