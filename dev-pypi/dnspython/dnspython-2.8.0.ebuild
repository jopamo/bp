# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="DNS toolkit"
HOMEPAGE="https://www.dnspython.org"
LICENSE="ISC"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8c/8b/57666417c0f90f08bcafa776861060426765fdb422eb10212086fb811d26/dnspython-2.8.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/dnspython-2.8.0"

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
