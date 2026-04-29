# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="tqdm"
DESCRIPTION="Fast, Extensible Progress Meter"
HOMEPAGE="https://tqdm.github.io"
LICENSE="MPL-2.0 MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
