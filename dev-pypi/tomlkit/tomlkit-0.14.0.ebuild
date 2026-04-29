# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="poetry"

inherit distutils-r1

DESCRIPTION="Style preserving TOML library"
HOMEPAGE="https://github.com/sdispater/tomlkit"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c3/af/14b24e41977adb296d6bd1fb59402cf7d60ce364f90c890bd2ec65c43b5a/tomlkit-0.14.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/tomlkit-0.14.0"
