# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="sphinxcontrib-jsmath"
DESCRIPTION="A sphinx extension which renders display math in HTML via JavaScript"
HOMEPAGE="http://sphinx-doc.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
