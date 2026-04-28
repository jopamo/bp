# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="prompt-toolkit"
DESCRIPTION="Library for building powerful interactive command lines in Python"
HOMEPAGE="https://github.com/prompt-toolkit/python-prompt-toolkit"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-python/wcwidth
"
# lockstep-pypi-deps: end
