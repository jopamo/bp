# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( pypy3 pypy3_11 python3_{10..13} )

inherit distutils-r1

DESCRIPTION="Fancy PyPI READMEs with Hatch"
HOMEPAGE="
	https://pypi.org/project/hatch-fancy-pypi-readme/
	https://github.com/hynek/hatch-fancy-pypi-readme/
"
SRC_URI="
	https://github.com/hynek/hatch-fancy-pypi-readme/archive/${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-python/hatchling[${PYTHON_USEDEP}]
	$(python_gen_cond_dep '
		dev-python/tomli[${PYTHON_USEDEP}]
	' 3.{9..10})
"

distutils_enable_tests pytest

EPYTEST_DESELECT=(
	# fails without Internet (via pip)
	tests/test_end_to_end.py
)
