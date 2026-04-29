# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="keyring"
DESCRIPTION="Store and access your passwords safely."
HOMEPAGE="https://pypi.org/project/keyring/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-classes
	dev-pypi/jaraco-context
	dev-pypi/jaraco-functools
	dev-pypi/jeepney
	dev-pypi/secretstorage
"
# lockstep-pypi-deps: end
