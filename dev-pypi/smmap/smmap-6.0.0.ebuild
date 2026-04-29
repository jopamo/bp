# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="A pure Python implementation of a sliding window memory map manager"
HOMEPAGE="https://github.com/gitpython-developers/smmap"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/c3/02/a17f48f783b2668bae4837385d073b98f8b3afdfd97a917e61b921e59d16/smmap-6.0.0.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/smmap-6.0.0"
