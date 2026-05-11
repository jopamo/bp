# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="FIDO2/WebAuthn library for implementing clients and servers."
HOMEPAGE="https://github.com/Yubico/python-fido2"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/09/34/4837e2f5640baf61d8abd6125ccb6cc60b4b2933088528356ad6e781496f/fido2-2.2.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fido2-2.2.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/cryptography
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
