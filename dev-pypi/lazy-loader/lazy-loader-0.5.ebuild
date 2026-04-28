# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="lazy-loader"
DESCRIPTION="Makes it easy to load subpackages and functions on demand."
HOMEPAGE="https://pypi.org/project/lazy-loader/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-python/packaging
"
# lockstep-pypi-deps: end
