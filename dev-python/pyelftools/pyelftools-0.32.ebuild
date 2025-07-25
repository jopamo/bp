# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{11..14} )

inherit distutils-r1

DESCRIPTION="pure-Python library for analyzing ELF files and DWARF debugging information"
HOMEPAGE="
	https://pypi.org/project/pyelftools/
	https://github.com/eliben/pyelftools/
"
# PyPI tarball lacks some test files
SRC_URI="
	https://github.com/eliben/pyelftools/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="public-domain"
SLOT="0"
KEYWORDS="amd64 arm64"

python_test() {
	# readelf_tests often fails due to host `readelf` changing output format
	"${EPYTHON}" test/run_all_unittests.py || die
	"${EPYTHON}" test/run_examples_test.py || die
}
