# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="The ultimate Python library in building OAuth and OpenID Connect servers and clients."
HOMEPAGE="https://pypi.org/project/authlib/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/36/98/7d93f30d029643c0275dbc0bd6d5a6f670661ee6c9a94d93af7ab4887600/authlib-1.7.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/authlib-1.7.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/cryptography
	dev-pypi/joserfc
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
	dev-pypi/wheel[${PYTHON_USEDEP}]
"
