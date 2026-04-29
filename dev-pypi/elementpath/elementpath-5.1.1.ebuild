# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="XPath 1.0/2.0/3.0/3.1 parsers and selectors for ElementTree and lxml"
HOMEPAGE="https://github.com/sissaschool/elementpath"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/94/95/eeb61a2a917bf506d1402748e71c62399d8dcdd8cdccd64c81962832c260/elementpath-5.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/elementpath-5.1.1"
