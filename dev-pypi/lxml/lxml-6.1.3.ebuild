# lockstep-managed: dependency-ebuild
# lockstep-pypi-managed: true
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

PYTHON_COMPAT=( python3_{11..14} )
DISTUTILS_EXT=1
DEPEND="lib-core/libxml2 lib-core/libxslt"
RDEPEND="${DEPEND}"
export WITHOUT_CYTHON=1

DISTUTILS_USE_PEP517="setuptools"

inherit distutils-r1

DESCRIPTION="Powerful and Pythonic XML processing library combining libxml2/libxslt with the ElementTree API."
HOMEPAGE="https://lxml.de/"
LICENSE="BSD-3-Clause"
SLOT="0"
KEYWORDS="amd64 arm64"

SRC_URI="https://files.pythonhosted.org/packages/23/ad/28ecd7cb894d172f3c9c80a075eeeb2017ac62e3632cee05a5f9493547eb/lxml-6.1.3.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/lxml-6.1.3"

BDEPEND="
	dev-pypi/setuptools[${PYTHON_USEDEP}]
"

python_prepare_all() {
	# Release archives contain generated C; do not regenerate it with host Cython.
	grep -Fx 'requires = ["Cython>=3.2.9,<3.3", "setuptools"]' pyproject.toml \
		|| die "lxml build requirements changed"
	sed -i 's/requires = \["Cython>=3.2.9,<3.3", "setuptools"\]/requires = ["setuptools"]/' \
		pyproject.toml || die
	distutils-r1_python_prepare_all
}

distutils_enable_tests unittest

python_test() {
	"${EPYTHON}" - <<-'PY' || die "lxml tests failed"
	from pathlib import Path
	import lxml
	import lxml.html
	import test

	# Wheels omit tests; extend only the package search paths for source fixtures.
	lxml.__path__.append(str(Path("src/lxml").resolve()))
	lxml.html.__path__.append(str(Path("src/lxml/html").resolve()))
	raise SystemExit(test.main(["test.py", "--no-src", "-v"]))
	PY
}
