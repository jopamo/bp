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

SRC_URI="https://files.pythonhosted.org/packages/e7/3c/c65377e48c144afca6b02c69f10c0fe936db556096a4e2c9798e2aa72db6/fido2-2.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fido2-2.1.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
"
# lockstep-pypi-deps: end
