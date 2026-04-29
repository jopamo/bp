# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="WebSocket library for Trio"
HOMEPAGE="https://github.com/python-trio/trio-websocket"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d1/3c/8b4358e81f2f2cfe71b66a267f023a91db20a817b9425dd964873796980a/trio_websocket-0.12.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/trio_websocket-0.12.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/outcome
	dev-pypi/trio
	dev-pypi/wsproto
"
# lockstep-pypi-deps: end
