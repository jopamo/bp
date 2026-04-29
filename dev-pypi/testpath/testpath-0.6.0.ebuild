# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

PYPI_PN="testpath"
DESCRIPTION="Test utilities for code working with files and commands"
HOMEPAGE="https://pypi.org/project/testpath/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
