# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="tempora"
DESCRIPTION="Objects and routines pertaining to date and time (tempora)"
HOMEPAGE="https://pypi.org/project/tempora/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-python/jaraco-functools
	dev-python/python-dateutil
"
# lockstep-pypi-deps: end
