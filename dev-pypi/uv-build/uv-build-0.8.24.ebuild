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

SRC_URI="https://files.pythonhosted.org/packages/50/60/6d96c3dd49223156b7f7b7eb4b79f94727cb529806b2c086f75d4dfb7ca6/uv_build-0.8.24.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/uv_build-0.8.24"

BDEPEND="
	app-dev/maturin[${PYTHON_USEDEP}]
"
