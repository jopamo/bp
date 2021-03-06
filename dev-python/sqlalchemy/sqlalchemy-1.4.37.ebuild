# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1 flag-o-matic

MY_PN="SQLAlchemy"
MY_P="${MY_PN}-${PV/_beta/b}"

DESCRIPTION="Python SQL toolkit and Object Relational Mapper"
HOMEPAGE="http://www.sqlalchemy.org/ https://pypi.python.org/pypi/SQLAlchemy"
SRC_URI="mirror://pypi/${MY_P:0:1}/${MY_PN}/${MY_P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+sqlite test"

REQUIRED_USE="test? ( sqlite )"

RDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]"

DEPEND="
	${RDEPEND}
	test? (
		dev-python/pytest[${PYTHON_USEDEP}]
	)"

S="${WORKDIR}/${MY_P}"

python_prepare_all() {
	# Disable tests hardcoding function call counts specific to Python versions.
	rm -r test/aaa_profiling || die
	distutils-r1_python_prepare_all
}

python_test() {
	# Create copies of necessary files in BUILD_DIR.
	# https://bitbucket.org/zzzeek/sqlalchemy/issue/3144/
	cp -pR examples sqla_nose.py setup.cfg test "${BUILD_DIR}" || die
	pushd "${BUILD_DIR}" > /dev/null || die
	if [[ "${EPYTHON}" == "python3.2" ]]; then
		2to3 --no-diffs -w test || die
	fi
	# Recently upstream elected to make the testsuite also pytest capable
	# "${PYTHON}" sqla_nose.py || die "Testsuite failed under ${EPYTHON}"
	py.test --verbose test || die "Testsuite failed under ${EPYTHON}"
	popd > /dev/null
}
