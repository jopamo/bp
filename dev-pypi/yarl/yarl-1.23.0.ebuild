# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="yarl"
DESCRIPTION="Yet another URL library"
HOMEPAGE="https://github.com/aio-libs/yarl"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/idna
	dev-pypi/multidict
	dev-pypi/propcache
"
# lockstep-pypi-deps: end
