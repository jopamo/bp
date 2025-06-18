# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Reliable machine-readable Linux distribution information for Python"
HOMEPAGE="
	https://distro.readthedocs.io/en/latest/
	https://github.com/python-distro/distro/
	https://pypi.org/project/distro/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest
