# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="scikit-build-core"

inherit distutils-r1 pypi

PYPI_PN="pyzmq"
DESCRIPTION="Python bindings for 0MQ"
HOMEPAGE="https://pyzmq.readthedocs.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
