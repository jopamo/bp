# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

PYPI_PN="josepy"
DESCRIPTION="JOSE protocol implementation in Python"
HOMEPAGE="https://github.com/certbot/josepy"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
"
# lockstep-pypi-deps: end
