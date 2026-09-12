# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Coroutine-based network library"
HOMEPAGE="http://www.gevent.org/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b8/eb/5f2db8013f1a4a6df2c23201f384a066f13ff5764a9f62a608c8a50ac8cc/gevent-26.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gevent-26.8.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/greenlet
	dev-pypi/zope-event
	dev-pypi/zope-interface
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/cffi[${PYTHON_USEDEP}]
	dev-pypi/cython[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/greenlet[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
