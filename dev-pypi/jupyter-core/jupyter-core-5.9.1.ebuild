# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="jupyter-core"
DESCRIPTION="Jupyter core package. A base package on which Jupyter projects rely."
HOMEPAGE="https://jupyter.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-python/platformdirs
	dev-python/traitlets
"
# lockstep-pypi-deps: end
