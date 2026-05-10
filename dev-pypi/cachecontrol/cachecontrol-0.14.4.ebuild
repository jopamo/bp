# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="uv-build"

inherit distutils-r1 pypi

DESCRIPTION="httplib2 caching for requests"
HOMEPAGE="
	https://pypi.org/project/CacheControl/
	https://github.com/psf/cachecontrol/
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/msgpack
	dev-pypi/requests
"
# lockstep-pypi-deps: end
RDEPEND="
	>=dev-pypi/msgpack-0.5.2[${PYTHON_USEDEP}]
	<dev-pypi/msgpack-2[${PYTHON_USEDEP}]
	>=dev-pypi/requests-2.16.0[${PYTHON_USEDEP}]
"
