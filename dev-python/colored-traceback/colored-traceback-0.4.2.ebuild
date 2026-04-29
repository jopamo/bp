# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
DESCRIPTION="Automatically color Python's uncaught exception tracebacks"
HOMEPAGE="
	https://github.com/staticshock/colored-traceback.py/
	https://pypi.org/project/colored-traceback/
"

LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/pygments[${PYTHON_USEDEP}]
"
