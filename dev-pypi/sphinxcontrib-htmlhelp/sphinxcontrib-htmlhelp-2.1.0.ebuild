# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="sphinxcontrib-htmlhelp"
DESCRIPTION="sphinxcontrib-htmlhelp is a sphinx extension which renders HTML help files"
HOMEPAGE="https://www.sphinx-doc.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
