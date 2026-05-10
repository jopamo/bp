# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="flit"

inherit distutils-r1 pypi

DESCRIPTION="Verify certificates using native system trust stores"
HOMEPAGE="
	https://github.com/sethmlarson/truststore/
	https://pypi.org/project/truststore/
	https://truststore.readthedocs.io/
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
