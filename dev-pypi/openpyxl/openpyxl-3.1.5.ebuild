# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="openpyxl"
DESCRIPTION="A Python library to read/write Excel 2010 xlsx/xlsm files"
HOMEPAGE="https://openpyxl.readthedocs.io"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/et-xmlfile
"
# lockstep-pypi-deps: end
