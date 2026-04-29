# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="annotated-types"
DESCRIPTION="Reusable constraint types to use with typing.Annotated"
HOMEPAGE="https://github.com/annotated-types/annotated-types"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
