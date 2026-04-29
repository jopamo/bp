# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="unix-ar"
DESCRIPTION="AR file handling"
HOMEPAGE="https://github.com/getninjas/unix_ar"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
