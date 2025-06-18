# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="A configurable sidebar-enabled Sphinx theme"
HOMEPAGE="
	https://github.com/sphinx-doc/alabaster/
	https://pypi.org/project/alabaster/
"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"
