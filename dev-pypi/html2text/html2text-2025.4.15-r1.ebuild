# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Turn HTML into equivalent Markdown-structured text."
HOMEPAGE="https://github.com/Alir3z4/html2text/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/f8/27/e158d86ba1e82967cc2f790b0cb02030d4a8bef58e0c79a8590e9678107f/html2text-2025.4.15.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/html2text-2025.4.15"
