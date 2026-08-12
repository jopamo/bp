# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="Core utilities for Python packages"
HOMEPAGE="https://pypi.org/project/packaging/"
LICENSE="|| ( Apache-2.0 BSD-2-Clause )"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/7d/fa/3944b40b07da9ce895c0e6303a5ab7d53da063554f534556b134a54d6093/packaging-26.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/packaging-26.3"

BDEPEND="
	dev-pypi/flit-core[${PYTHON_USEDEP}]
	dev-pypi/gpep517[${PYTHON_USEDEP}]
"
