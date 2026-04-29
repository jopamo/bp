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

SRC_URI="https://files.pythonhosted.org/packages/da/8a/22b7beea3ee0d44b1916c0c1cb0ee3af23b700b6da9f04991899d0c555d4/rsa-4.9.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/rsa-4.9.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pyasn1
"
# lockstep-pypi-deps: end
