# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="requests"
DESCRIPTION="Python HTTP for Humans."
HOMEPAGE="https://pypi.org/project/requests/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/certifi
	dev-pypi/charset-normalizer
	dev-pypi/idna
	dev-pypi/urllib3
"
# lockstep-pypi-deps: end
