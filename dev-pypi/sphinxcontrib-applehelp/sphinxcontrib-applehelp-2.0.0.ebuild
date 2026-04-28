# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="sphinxcontrib-applehelp"
DESCRIPTION="sphinxcontrib-applehelp is a Sphinx extension which outputs Apple help books"
HOMEPAGE="https://www.sphinx-doc.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
