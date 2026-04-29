# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Python package to parse, read and write Microsoft OLE2 files (Structured Storage or Compound Document, Microsoft Office)"
HOMEPAGE="https://www.decalage.info/python/olefileio"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/69/1b/077b508e3e500e1629d366249c3ccb32f95e50258b231705c09e3c7a4366/olefile-0.47.zip -> ${P}.zip"
S="${WORKDIR}/olefile-0.47"
