# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Measures the displayed width of unicode strings in a terminal"
HOMEPAGE="https://github.com/jquast/wcwidth"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2c/ee/afaf0f85a9a18fe47a67f1e4422ed6cf1fe642f0ae0a2f81166231303c52/wcwidth-0.7.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/wcwidth-0.7.0"

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
"
