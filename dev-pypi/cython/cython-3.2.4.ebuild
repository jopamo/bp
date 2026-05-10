# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="The Cython compiler for writing C extensions in the Python language."
HOMEPAGE="https://cython.org/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/91/85/7574c9cd44b69a27210444b6650f6477f56c75fee1b70d7672d3e4166167/cython-3.2.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cython-3.2.4"
