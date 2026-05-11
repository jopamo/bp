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

SRC_URI="https://files.pythonhosted.org/packages/20/27/1062fa31333dc3428a1f5f33cd6598b0552165ba679ca3ba116de42c9e8e/gevent-26.4.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gevent-26.4.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/greenlet
	dev-pypi/zope-event
	dev-pypi/zope-interface
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/cffi[${PYTHON_USEDEP}]
	dev-py/cython[${PYTHON_USEDEP}]
	dev-pypi/greenlet[${PYTHON_USEDEP}]
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
