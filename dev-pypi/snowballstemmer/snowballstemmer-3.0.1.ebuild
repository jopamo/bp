# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8

PYTHON_COMPAT=( python3_{11..14} )

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1 pypi

PYPI_PN="snowballstemmer"
DESCRIPTION="This package provides 32 stemmers for 30 languages generated from Snowball algorithms."
HOMEPAGE="https://github.com/snowballstem/snowball"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"
