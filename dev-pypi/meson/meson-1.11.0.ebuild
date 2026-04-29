# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A high performance build system"
HOMEPAGE="https://mesonbuild.com"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1b/88/23a6aefb29398b290469914e9ecbdd21803bd53c826aa75e4e2a9b778e98/meson-1.11.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/meson-1.11.0"
