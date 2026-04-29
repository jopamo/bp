# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

PYPI_PN="rsa"
DESCRIPTION="Pure-Python RSA implementation"
HOMEPAGE="https://stuvel.eu/rsa"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pyasn1
"
# lockstep-pypi-deps: end
