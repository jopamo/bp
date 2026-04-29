# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1

DESCRIPTION="A small Python package for determining appropriate platform-specific dirs, e.g. a \`user data dir\`."
HOMEPAGE="https://github.com/tox-dev/platformdirs"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/19/56/8d4c30c8a1d07013911a8fdbd8f89440ef9f08d07a1b50ab8ca8be5a20f9/platformdirs-4.9.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/platformdirs-4.9.4"
