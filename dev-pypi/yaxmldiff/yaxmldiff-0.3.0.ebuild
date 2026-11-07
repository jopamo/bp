# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="yaxmldiff is Yet Another XML Differ"
HOMEPAGE="https://pypi.org/project/yaxmldiff/"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b5/01/3a2a92ea33e37e5b42165c7aae63768b5d8c4979f3f4902473833badc287/yaxmldiff-0.3.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/yaxmldiff-0.3.0"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/cappa
	dev-pypi/lxml
"
# lockstep-pypi-deps: end

BDEPEND="
	dev-pypi/gpep517[${PYTHON_USEDEP}]
	dev-pypi/hatch-fancy-pypi-readme[${PYTHON_USEDEP}]
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
