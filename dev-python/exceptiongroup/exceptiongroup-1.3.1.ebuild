# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit_scm
PYPI_VERIFY_REPO=https://github.com/agronholm/exceptiongroup
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Backport of PEP 654 (exception groups)"
HOMEPAGE="
	https://github.com/agronholm/exceptiongroup/
	https://pypi.org/project/exceptiongroup/
"

LICENSE="MIT PSF-2.4"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	$(python_gen_cond_dep '
		>=dev-python/typing-extensions-4.6.0[${PYTHON_USEDEP}]
	' 3.11 3.12)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
