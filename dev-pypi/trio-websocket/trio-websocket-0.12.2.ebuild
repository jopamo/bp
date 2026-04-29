# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="trio-websocket"
DESCRIPTION="WebSocket library for Trio"
HOMEPAGE="https://github.com/python-trio/trio-websocket"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/outcome
	dev-pypi/trio
	dev-pypi/wsproto
"
# lockstep-pypi-deps: end
