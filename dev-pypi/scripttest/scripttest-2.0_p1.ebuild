# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="scripttest"
DESCRIPTION="Helper to test command-line scripts"
HOMEPAGE="https://scripttest.readthedocs.io/en/stable/"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
