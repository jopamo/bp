# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="h2"
DESCRIPTION="Pure-Python HTTP/2 protocol implementation"
HOMEPAGE="https://github.com/python-hyper/h2/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/hpack
	dev-pypi/hyperframe
"
# lockstep-pypi-deps: end
