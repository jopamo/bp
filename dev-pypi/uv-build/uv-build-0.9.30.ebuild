# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="maturin"

inherit distutils-r1

DESCRIPTION="The uv build backend"
HOMEPAGE="https://pypi.org/project/uv/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/ef/b0/dcd2fb2b9564f1c477abc90331571c06694a4871aba517223f5a6ab28f2b/uv_build-0.9.30.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uv_build-0.9.30"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
