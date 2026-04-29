# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A Python ASGI web framework with the same API as Flask"
HOMEPAGE="https://pypi.org/project/quart/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1d/9d/12e1143a5bd2ccc05c293a6f5ae1df8fd94a8fc1440ecc6c344b2b30ce13/quart-0.20.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/quart-0.20.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/aiofiles
	dev-pypi/blinker
	dev-pypi/click
	dev-pypi/flask
	dev-pypi/hypercorn
	dev-pypi/itsdangerous
	dev-pypi/jinja2
	dev-pypi/markupsafe
	dev-pypi/werkzeug
"
# lockstep-pypi-deps: end
