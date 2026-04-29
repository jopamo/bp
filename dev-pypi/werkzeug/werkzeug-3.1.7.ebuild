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

SRC_URI="https://files.pythonhosted.org/packages/b5/43/76ded108b296a49f52de6bac5192ca1c4be84e886f9b5c9ba8427d9694fd/werkzeug-3.1.7.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/werkzeug-3.1.7"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markupsafe
"
# lockstep-pypi-deps: end
