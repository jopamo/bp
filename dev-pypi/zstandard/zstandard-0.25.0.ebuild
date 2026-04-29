# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Zstandard bindings for Python"
HOMEPAGE="https://github.com/indygreg/python-zstandard"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/fd/aa/3e0508d5a5dd96529cdc5a97011299056e14c6505b678fd58938792794b1/zstandard-0.25.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/zstandard-0.25.0"
