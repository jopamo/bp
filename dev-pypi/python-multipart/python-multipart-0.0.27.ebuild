# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A streaming multipart parser for Python"
HOMEPAGE="https://github.com/Kludex/python-multipart"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/69/9b/f23807317a113dc36e74e75eb265a02dd1a4d9082abc3c1064acd22997c4/python_multipart-0.0.27.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python_multipart-0.0.27"
