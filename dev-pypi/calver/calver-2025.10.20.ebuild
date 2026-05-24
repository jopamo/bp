# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

DESCRIPTION="Setuptools extension for CalVer package versions"
HOMEPAGE="https://github.com/di/calver"
LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

PYPI_PN="calver"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"
