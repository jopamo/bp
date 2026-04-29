# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1

DESCRIPTION="The PyPA recommended tool for installing Python packages."
HOMEPAGE="https://pip.pypa.io/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/48/83/0d7d4e9efe3344b8e2fe25d93be44f64b65364d3c8d7bc6dc90198d5422e/pip-26.0.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/pip-26.0.1"
