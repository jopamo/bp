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

SRC_URI="https://files.pythonhosted.org/packages/de/c6/de8fdbdfa75c8ca04fead38a82d573df8a82906e984c349d58665f459558/joserfc-1.6.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/joserfc-1.6.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
"
# lockstep-pypi-deps: end
