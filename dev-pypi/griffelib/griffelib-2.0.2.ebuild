# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="Signatures for entire Python programs. Extract the structure, the frame, the skeleton of your project, to generate API documentation or find breaking changes in your API."
HOMEPAGE="https://pypi.org/project/griffelib/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9d/82/74f4a3310cdabfbb10da554c3a672847f1ed33c6f61dd472681ce7f1fe67/griffelib-2.0.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/griffelib-2.0.2"

BDEPEND="
	dev-pypi/hatchling[${PYTHON_USEDEP}]
	dev-pypi/pdm-backend[${PYTHON_USEDEP}]
	dev-pypi/uv-dynamic-versioning[${PYTHON_USEDEP}]
"
