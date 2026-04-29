# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="httplib2 caching for requests"
HOMEPAGE="https://pypi.org/project/CacheControl/"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/2d/f6/c972b32d80760fb79d6b9eeb0b3010a46b89c0b23cf6329417ff7886cd22/cachecontrol-0.14.4.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/cachecontrol-0.14.4"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/msgpack
	dev-pypi/requests
"
# lockstep-pypi-deps: end
