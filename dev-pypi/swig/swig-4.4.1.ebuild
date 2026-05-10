# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="scikit-build-core"

inherit distutils-r1

DESCRIPTION="SWIG is a software development tool that connects programs written in C and C++ with a variety of high-level programming languages."
HOMEPAGE="https://swig.org/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/9c/99/0556919f96b1c291a7ff83793adb328e2a1a5e6cfb379d5acc637cdec959/swig-4.4.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/swig-4.4.1"

BDEPEND="
	dev-pypi/scikit-build-core[${PYTHON_USEDEP}]
"
