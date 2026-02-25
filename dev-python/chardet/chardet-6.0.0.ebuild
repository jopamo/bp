# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
DISTUTILS_USE_PEP517=hatchling

inherit distutils-r1 pypi

DESCRIPTION="Universal encoding detector"
HOMEPAGE="
	https://github.com/chardet/chardet/
	https://pypi.org/project/chardet/
"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# super flaky test
	# https://github.com/chardet/chardet/issues/256
	test.py::test_detect_all_and_detect_one_should_agree
)
