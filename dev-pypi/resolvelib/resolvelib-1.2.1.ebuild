# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Resolve abstract dependencies into concrete ones"
HOMEPAGE="https://github.com/sarugaku/resolvelib"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/1d/14/4669927e06631070edb968c78fdb6ce8992e27c9ab2cde4b3993e22ac7af/resolvelib-1.2.1.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/resolvelib-1.2.1"
