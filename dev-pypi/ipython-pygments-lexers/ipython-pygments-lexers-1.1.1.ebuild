# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Defines a variety of Pygments lexers for highlighting IPython code."
HOMEPAGE="https://pypi.org/project/ipython-pygments-lexers/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ef/4c/5dd1d8af08107f88c7f741ead7a40854b8ac24ddf9ae850afbcf698aa552/ipython_pygments_lexers-1.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/ipython_pygments_lexers-1.1.1"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
