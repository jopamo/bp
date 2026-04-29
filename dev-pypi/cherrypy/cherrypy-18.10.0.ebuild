# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Object-Oriented HTTP framework"
HOMEPAGE="https://www.cherrypy.dev"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/93/e8/2f7ef142d1962d08a8885c4c9942212abecad6a80ccdd1620fd1f5c993fd/cherrypy-18.10.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cherrypy-18.10.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cheroot
	dev-pypi/jaraco-collections
	dev-pypi/more-itertools
	dev-pypi/portend
	dev-pypi/zc-lockfile
"
# lockstep-pypi-deps: end
