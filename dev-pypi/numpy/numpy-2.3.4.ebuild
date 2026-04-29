# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Fundamental package for array computing in Python"
HOMEPAGE="https://numpy.org"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/b5/f4/098d2270d52b41f1bd7db9fc288aaa0400cb48c2a3e2af6fa365d9720947/numpy-2.3.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/numpy-2.3.4"
