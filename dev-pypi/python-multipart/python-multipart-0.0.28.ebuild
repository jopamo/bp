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

SRC_URI="https://files.pythonhosted.org/packages/82/54/a85eb421fbdd5007bc5af39d0f4ed9fa609e0fedbfdc2adcf0b34526870e/python_multipart-0.0.28.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/python_multipart-0.0.28"

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
