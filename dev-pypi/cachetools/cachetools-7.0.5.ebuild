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

SRC_URI="https://files.pythonhosted.org/packages/af/dd/57fe3fdb6e65b25a5987fd2cdc7e22db0aef508b91634d2e57d22928d41b/cachetools-7.0.5.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cachetools-7.0.5"
