# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="ipython-pygments-lexers"
DESCRIPTION="Defines a variety of Pygments lexers for highlighting IPython code."
HOMEPAGE="https://pypi.org/project/ipython-pygments-lexers/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
