# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Retrying"
HOMEPAGE="https://github.com/groodt/retrying"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c8/5a/b17e1e257d3e6f2e7758930e1256832c9ddd576f8631781e6a072914befa/retrying-1.4.2.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/retrying-1.4.2"
