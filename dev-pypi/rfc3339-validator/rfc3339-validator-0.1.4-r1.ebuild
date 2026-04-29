# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="rfc3339-validator"
DESCRIPTION="A pure python RFC3339 validator"
HOMEPAGE="https://github.com/naimetti/rfc3339-validator"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
