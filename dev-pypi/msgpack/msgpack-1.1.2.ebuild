# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="MessagePack serializer"
HOMEPAGE="
	https://msgpack.org/
	https://github.com/msgpack/msgpack-python/
	https://pypi.org/project/msgpack/
"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"
