# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python library for arbitrary-precision floating-point arithmetic"
HOMEPAGE="https://mpmath.org/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c5/b0/6de8e78014ff1842a90cc9a56da6ccfb598a5390ed0257fcdb7d9680c18b/mpmath-1.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/mpmath-1.4.1"
