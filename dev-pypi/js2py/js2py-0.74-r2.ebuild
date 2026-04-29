# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="JavaScript to Python Translator & JavaScript interpreter written in 100% pure Python."
HOMEPAGE="https://github.com/PiotrDabkowski/Js2Py"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/cb/a5/3d8b3e4511cc21479f78f359b1b21f1fb7c640988765ffd09e55c6605e3b/Js2Py-0.74.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/Js2Py-0.74"
