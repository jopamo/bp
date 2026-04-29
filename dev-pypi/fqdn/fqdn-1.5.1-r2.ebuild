# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="fqdn"
DESCRIPTION="Validates fully-qualified domain names against RFC 1123, so that they are acceptable to modern bowsers"
HOMEPAGE="https://github.com/ypcrts/fqdn"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
