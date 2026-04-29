# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="A very fast and expressive template engine."
HOMEPAGE="https://pypi.org/project/jinja2/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/df/bf/f7da0350254c0ed7c72f3e33cef02e048281fec7ecec5f032d4aac52226b/jinja2-3.1.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/jinja2-3.1.6"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markupsafe
"
# lockstep-pypi-deps: end
