# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Pure-Python WebSocket protocol implementation"
HOMEPAGE="https://github.com/python-hyper/wsproto/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c7/79/12135bdf8b9c9367b8701c2c19a14c913c120b882d50b014ca0d38083c2c/wsproto-1.3.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/wsproto-1.3.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/h11
"
# lockstep-pypi-deps: end
