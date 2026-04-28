# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="ipython"
DESCRIPTION="IPython: Productive Interactive Computing"
HOMEPAGE="https://ipython.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/decorator
	dev-pypi/ipython-pygments-lexers
	dev-pypi/matplotlib-inline
	dev-pypi/prompt-toolkit
	dev-pypi/stack-data
	dev-python/jedi
	dev-python/pexpect
	dev-python/psutil
	dev-python/pygments
	dev-python/traitlets
"
# lockstep-pypi-deps: end
