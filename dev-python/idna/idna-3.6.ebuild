# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{10..12} pypy3 )

inherit distutils-r1 pypi

DESCRIPTION="Internationalized Domain Names in Applications (IDNA)"
HOMEPAGE="
	https://github.com/kjd/idna/
	https://pypi.org/project/idna/
"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64 arm64"

distutils_enable_tests unittest
