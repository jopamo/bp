# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="The uv build backend"
HOMEPAGE="https://pypi.org/project/uv/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/10/0c/8f222aec5e208eeeeb2743801423c8993d4f39cd791d5f12333c6f6e1abb/uv_build-0.11.12.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uv_build-0.11.12"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
