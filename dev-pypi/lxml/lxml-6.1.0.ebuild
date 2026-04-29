# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API."
HOMEPAGE="https://lxml.de/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/28/30/9abc9e34c657c33834eaf6cd02124c61bdf5944d802aa48e69be8da3585d/lxml-6.1.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lxml-6.1.0"
