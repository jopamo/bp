# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Highly-optimized, pure-python HTTP server"
HOMEPAGE="https://cheroot.cherrypy.dev"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/68/e4/5c2020b60a55aca8d79ed55b62ad1cd7fc47ea44ad6b584e83f5f1bf58b0/cheroot-11.1.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cheroot-11.1.2"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/jaraco-functools
	dev-pypi/more-itertools
"
# lockstep-pypi-deps: end
