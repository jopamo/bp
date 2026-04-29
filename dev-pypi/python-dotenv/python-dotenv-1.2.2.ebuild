# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="python-dotenv"
DESCRIPTION="Read key-value pairs from a .env file and set them as environment variables"
HOMEPAGE="https://pypi.org/project/python-dotenv/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"
