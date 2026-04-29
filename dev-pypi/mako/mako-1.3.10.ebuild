# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYPI_PN=${PN^}
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/markupsafe
"
# lockstep-pypi-deps: end
DESCRIPTION="A Python templating language"
HOMEPAGE="
	https://www.makotemplates.org/
	https://github.com/sqlalchemy/mako/
	https://pypi.org/project/Mako/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="doc"

RDEPEND="
	>=dev-pypi/markupsafe-0.9.2[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-pypi/babel[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

python_test() {
	local EPYTEST_DESELECT=()
	case ${EPYTHON} in
		pypy3)
		EPYTEST_DESELECT+=(
			test/test_exceptions.py::ExceptionsTest::test_alternating_file_names
		)
		;;
	esac

	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest
}

python_install_all() {
	rm -r doc/build || die

	use doc && local HTML_DOCS=( doc/. )
	distutils-r1_python_install_all
}
