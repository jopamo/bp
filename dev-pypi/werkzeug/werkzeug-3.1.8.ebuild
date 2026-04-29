# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="The comprehensive WSGI web application library."
HOMEPAGE="https://pypi.org/project/werkzeug/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dd/b2/381be8cfdee792dd117872481b6e378f85c957dd7c5bca38897b08f765fd/werkzeug-3.1.8.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/werkzeug-3.1.8"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markupsafe
"
# lockstep-pypi-deps: end
