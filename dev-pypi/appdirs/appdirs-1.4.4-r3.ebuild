# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="appdirs"
DESCRIPTION="A small Python module for determining appropriate platform-specific dirs, e.g. a \"user data dir\"."
HOMEPAGE="http://github.com/ActiveState/appdirs"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
