# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

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
	dev-pypi/jedi
	dev-pypi/matplotlib-inline
	dev-pypi/pexpect
	dev-pypi/prompt-toolkit
	dev-pypi/psutil
	dev-pypi/pygments
	dev-pypi/stack-data
	dev-pypi/traitlets
"
# lockstep-pypi-deps: end
