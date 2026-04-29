# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Easily download, build, install, upgrade, and uninstall Python packages"
HOMEPAGE="https://github.com/pypa/setuptools"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://github.com/pypa/setuptools/archive/118f129dd0fb319058bd05f382c50188fd60a60e.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/setuptools-118f129dd0fb319058bd05f382c50188fd60a60e"
