# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="ANTLR 4.13.2 runtime for Python 3"
HOMEPAGE="http://www.antlr.org"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/33/5f/2cdf6f7aca3b20d3f316e9f505292e1f256a32089bd702034c29ebde6242/antlr4_python3_runtime-4.13.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/antlr4_python3_runtime-4.13.2"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
