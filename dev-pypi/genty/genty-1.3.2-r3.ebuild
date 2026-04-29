# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Allows you to run a test with multiple data sets"
HOMEPAGE="https://github.com/box/genty"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c9/bc/eee096fe9ecf1041944f1327cf6a2030fb2c59acd66580b692eb8b540233/genty-1.3.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/genty-1.3.2"
