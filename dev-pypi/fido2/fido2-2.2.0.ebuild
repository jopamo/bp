# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

DESCRIPTION="FIDO2/WebAuthn library for implementing clients and servers."
HOMEPAGE="https://github.com/Yubico/python-fido2"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="fido2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
"
# lockstep-pypi-deps: end
