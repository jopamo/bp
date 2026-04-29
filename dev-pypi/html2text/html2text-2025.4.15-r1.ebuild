# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="html2text"
DESCRIPTION="Turn HTML into equivalent Markdown-structured text."
HOMEPAGE="https://github.com/Alir3z4/html2text/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
