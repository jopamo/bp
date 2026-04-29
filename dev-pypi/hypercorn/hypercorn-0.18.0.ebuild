# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1

DESCRIPTION="A ASGI Server based on Hyper libraries and inspired by Gunicorn"
HOMEPAGE="https://pypi.org/project/hypercorn/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/44/01/39f41a014b83dd5c795217362f2ca9071cf243e6a75bdcd6cd5b944658cc/hypercorn-0.18.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/hypercorn-0.18.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/h11
	dev-pypi/h2
	dev-pypi/priority
	dev-pypi/wsproto
"
# lockstep-pypi-deps: end
