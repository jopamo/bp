# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_EXT=1
DISTUTILS_USE_PEP517=standalone
PYTHON_COMPAT=( python3_{10..13} pypy3 )

inherit distutils-r1

MY_P=${P/_}
DESCRIPTION="YAML parser and emitter for Python"
HOMEPAGE="
	https://pyyaml.org/wiki/PyYAML
	https://pypi.org/project/PyYAML/
	https://github.com/yaml/pyyaml/
"
SRC_URI="
	https://github.com/yaml/pyyaml/archive/${PV/_}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="examples"

DEPEND="
	lib-dev/libyaml:=
"
RDEPEND="
	${DEPEND}
"
BDEPEND="
	dev-python/cython[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_configure() {
	export PYYAML_FORCE_CYTHON=1
}

python_test() {
	local -x PATH="${BUILD_DIR}/test${EPREFIX}/usr/bin:${PATH}"
	local -x PYTHONPATH="tests/legacy_tests:${PYTHONPATH}"
	# upstream indicates testing may pollute the package
	cp -a "${BUILD_DIR}"/{install,test} || die
	epytest
}

python_install_all() {
	distutils-r1_python_install_all
	if use examples; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}
	fi
}
