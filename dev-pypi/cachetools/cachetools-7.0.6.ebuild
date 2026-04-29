# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Extensible memoizing collections and decorators"
HOMEPAGE="https://github.com/tkem/cachetools/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/76/7b/1755ed2c6bfabd1d98b37ae73152f8dcf94aa40fee119d163c19ed484704/cachetools-7.0.6.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cachetools-7.0.6"
