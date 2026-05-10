# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Yet anohter radare2 python bindings."
HOMEPAGE="https://github.com/radareorg/radare2-bindings/tree/master/r2libr"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/8e/17/a3aff7cbf00a84e6ce4710cc6e65907b308721a03013a2bd4a09669455c7/r2libr-5.7.4-py3-none-macosx_10_15_universal2.whl -> ${P}.whl"
