# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Tools to manipulate font files"
HOMEPAGE="http://github.com/fonttools/fonttools"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9a/08/7012b00a9a5874311b639c3920270c36ee0c445b69d9989a85e5c92ebcb0/fonttools-4.62.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/fonttools-4.62.1"
