# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="psutil"
DESCRIPTION="Cross-platform lib for process and system monitoring."
HOMEPAGE="https://github.com/giampaolo/psutil"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"
