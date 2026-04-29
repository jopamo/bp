# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1 pypi

PYPI_PN="tomlkit"
DESCRIPTION="Style preserving TOML library"
HOMEPAGE="https://github.com/sdispater/tomlkit"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
