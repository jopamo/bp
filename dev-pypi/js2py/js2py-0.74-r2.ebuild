# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="js2py"
DESCRIPTION="JavaScript to Python Translator & JavaScript interpreter written in 100% pure Python."
HOMEPAGE="https://github.com/PiotrDabkowski/Js2Py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
