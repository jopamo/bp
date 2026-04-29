# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Pure-Python RSA implementation"
HOMEPAGE="https://stuvel.eu/rsa"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/aa/65/7d973b89c4d2351d7fb232c2e452547ddfa243e93131e7cfa766da627b52/rsa-4.9.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rsa-4.9"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pyasn1
"
# lockstep-pypi-deps: end
