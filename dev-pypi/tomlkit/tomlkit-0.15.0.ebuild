# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Style preserving TOML library"
HOMEPAGE="https://github.com/python-poetry/tomlkit"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/51/db/03eaf4331631ef6b27d6e3c9b68c54dc6f0d63d87201fed600cc409307fd/tomlkit-0.15.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tomlkit-0.15.0"

BDEPEND="
	dev-pypi/poetry-core[${PYTHON_USEDEP}]
"
