# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="stack-data"
DESCRIPTION="Extract data from python stack frames and tracebacks for informative displays"
HOMEPAGE="http://github.com/alexmojaki/stack_data"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/asttokens
	dev-pypi/executing
	dev-pypi/pure-eval
"
# lockstep-pypi-deps: end
