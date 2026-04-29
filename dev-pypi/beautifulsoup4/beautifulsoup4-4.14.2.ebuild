# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=hatchling
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/soupsieve
	dev-pypi/typing-extensions
"
# lockstep-pypi-deps: end
DESCRIPTION="Pythonic idioms for iterating, searching, and modifying an HTML/XML parse tree"
HOMEPAGE="https://www.crummy.com/software/BeautifulSoup/bs4/"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-py/html5lib[${PYTHON_USEDEP}]
	dev-py/lxml[${PYTHON_USEDEP}]
	>=dev-pypi/soupsieve-2.6[${PYTHON_USEDEP}]
	>=dev-pypi/typing-extensions-4.0.0[${PYTHON_USEDEP}]
"
# bs4 prefers cchardet > chardet > charset-normalizer
# however, charset-normalizer causes test failures, so force the other two
# dev-pypi/chardet[${PYTHON_USEDEP}]
BDEPEND="
	test? (
		|| (
			dev-py/faust-cchardet[${PYTHON_USEDEP}]
			dev-pypi/chardet[${PYTHON_USEDEP}]
		)
		dev-pypi/packaging[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=()
distutils_enable_tests pytest
distutils_enable_sphinx doc

EPYTEST_DESELECT=(
	# broken by security backports, already skipped on py3.13+
	"bs4/tests/test_fuzz.py::TestFuzz::test_rejected_markup[crash-ffbdfa8a2b26f13537b68d3794b0478a4090ee4a]"
)
