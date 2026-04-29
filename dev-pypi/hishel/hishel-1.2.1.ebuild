# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Elegant HTTP Caching for Python"
HOMEPAGE="https://hishel.com"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2d/7a/ef9231da56bc04000f7343831deb1946f5fc270213080fa212f61ddbfe0a/hishel-1.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hishel-1.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/msgpack
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
