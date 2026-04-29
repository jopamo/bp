# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="pdm-backend"

inherit distutils-r1 pypi

PYPI_PN="webcolors"
DESCRIPTION="A library for working with the color formats defined by HTML and CSS."
HOMEPAGE="https://pypi.org/project/webcolors/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"
