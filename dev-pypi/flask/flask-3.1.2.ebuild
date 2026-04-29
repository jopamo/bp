# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A simple framework for building complex web applications."
HOMEPAGE="https://pypi.org/project/flask/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dc/6d/cfe3c0fcc5e477df242b98bfe186a4c34357b4847e87ecaef04507332dab/flask-3.1.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/flask-3.1.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/blinker
	dev-pypi/click
	dev-pypi/itsdangerous
	dev-pypi/jinja2
	dev-pypi/markupsafe
	dev-pypi/werkzeug
"
# lockstep-pypi-deps: end
