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

SRC_URI="https://files.pythonhosted.org/packages/ba/ea/6f08c354b7aeb8019249d46a86c2153f8218499cced4d21bf16b6d49fc16/fido2-2.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fido2-2.2.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	app-crypto/cryptography
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
