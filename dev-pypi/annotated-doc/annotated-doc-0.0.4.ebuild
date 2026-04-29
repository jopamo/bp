# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1 pypi

PYPI_PN="annotated-doc"
DESCRIPTION="Document parameters, class attributes, return types, and variables inline, with Annotated."
HOMEPAGE="https://github.com/fastapi/annotated-doc"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
