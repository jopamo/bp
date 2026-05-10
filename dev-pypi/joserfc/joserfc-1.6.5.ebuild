# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="The ultimate Python library for JOSE RFCs, including JWS, JWE, JWK, JWA, JWT"
HOMEPAGE="https://pypi.org/project/joserfc/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/3b/dc/5f768c2e391e9afabe5d18e3221346deb5fb6338565f1ccc9e7c6d7befdd/joserfc-1.6.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/joserfc-1.6.5"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
