# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="zipp"
DESCRIPTION="Backport of pathlib-compatible object wrapper for zip files"
HOMEPAGE="https://pypi.org/project/zipp/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
