# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="hatchling"

inherit distutils-r1 pypi

PYPI_PN="plumbum"
DESCRIPTION="Plumbum: shell combinators library"
HOMEPAGE="https://github.com/tomerfiliba/plumbum"
LICENSE="metapackage"
SLOT="0"
KEYWORDS="amd64 arm64"
