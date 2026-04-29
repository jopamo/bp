# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="authlib"
DESCRIPTION="The ultimate Python library in building OAuth and OpenID Connect servers and clients."
HOMEPAGE="https://pypi.org/project/authlib/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cryptography
	dev-pypi/joserfc
"
# lockstep-pypi-deps: end
