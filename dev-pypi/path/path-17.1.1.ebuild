# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A module wrapper for os.path"
HOMEPAGE="https://pypi.org/project/path/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/dd/52/a7bdd5ef8488977d354b7915d1e75009bebbd04f73eff14e52372d5e9435/path-17.1.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/path-17.1.1"
