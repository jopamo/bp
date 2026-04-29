# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="IPython: Productive Interactive Computing"
HOMEPAGE="https://ipython.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/cd/c4/87cda5842cf5c31837c06ddb588e11c3c35d8ece89b7a0108c06b8c9b00a/ipython-9.13.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ipython-9.13.0"

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
