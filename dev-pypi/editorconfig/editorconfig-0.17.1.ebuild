# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="EditorConfig File Locator and Interpreter for Python"
HOMEPAGE="https://editorconfig.org/"
LICENSE="PSF-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/88/3a/a61d9a1f319a186b05d14df17daea42fcddea63c213bcd61a929fb3a6796/editorconfig-0.17.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/editorconfig-0.17.1"
