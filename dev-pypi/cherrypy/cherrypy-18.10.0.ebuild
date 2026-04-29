# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="cherrypy"
DESCRIPTION="Object-Oriented HTTP framework"
HOMEPAGE="https://www.cherrypy.dev"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cheroot
	dev-pypi/jaraco-collections
	dev-pypi/more-itertools
	dev-pypi/portend
	dev-pypi/zc-lockfile
"
# lockstep-pypi-deps: end
