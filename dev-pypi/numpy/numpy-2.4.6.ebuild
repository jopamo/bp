# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="meson-python"

inherit distutils-r1

DESCRIPTION="Fundamental package for array computing in Python"
HOMEPAGE="https://numpy.org"
LICENSE="BSD-3-Clause 0BSD MIT Zlib CC0-1.0"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/d0/ad/fed0499ce6a338d2a03ebae59cd15093910c8875328855781952abf6c2fe/numpy-2.4.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/numpy-2.4.6"

BDEPEND="
	dev-pypi/cython[${PYTHON_USEDEP}]
	dev-pypi/meson-python[${PYTHON_USEDEP}]
"
