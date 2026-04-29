# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
"
# lockstep-pypi-deps: end
TYPESHED_P="typeshed-ae9d4f4b21bb5e1239816c301da7b1ea904b44c3"
DJANGO_STUBS_P="django-stubs-3d2534ea8d8300c4c9db8f18e300355d5fd5488b"
EGIT_COMMIT="82d1902f382ddac5b0e6647646b72f28a3181ec3"

DESCRIPTION="Autocompletion library for Python"
HOMEPAGE="
	https://github.com/davidhalter/jedi/
	https://pypi.org/project/jedi/
"
SRC_URI="
	https://github.com/davidhalter/jedi/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
	https://github.com/davidhalter/typeshed/archive/${TYPESHED_P#typeshed-}.tar.gz
		-> ${TYPESHED_P}.tar.gz
	https://github.com/davidhalter/django-stubs/archive/${DJANGO_STUBS_P#django-stubs-}.tar.gz
		-> ${DJANGO_STUBS_P/v/}.tar.gz
"

LICENSE="
	MIT
	test? ( Apache-2.0 )
"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	<dev-pypi/parso-0.9[${PYTHON_USEDEP}]
	>=dev-pypi/parso-0.8.3[${PYTHON_USEDEP}]
"

# RDEPEND needed because of an import jedi inside conf.py
distutils_enable_sphinx docs \
	dev-pypi/parso \
	dev-py/sphinx-rtd-theme
distutils_enable_tests pytest

python_prepare_all() {
	# upstream includes these as submodules ...
	rmdir "${S}"/jedi/third_party/{django-stubs,typeshed} || die
	mv "${WORKDIR}/${DJANGO_STUBS_P/v/}" \
		"${S}/jedi/third_party/django-stubs" || die
	mv "${WORKDIR}/${TYPESHED_P}" \
		"${S}/jedi/third_party/typeshed" || die

	# test_complete_expanduser relies on $HOME not being empty
	> "${HOME}"/somefile || die

	distutils-r1_python_prepare_all
}

python_test() {
	local EPYTEST_DESELECT=(
		# fragile
		test/test_speed.py
		# assumes pristine virtualenv
		test/test_inference/test_imports.py::test_duplicated_import
		test/test_inference/test_imports.py::test_os_issues
	)

	case ${EPYTHON} in
		pypy3.11)
			EPYTEST_DESELECT+=(
				test/test_api/test_interpreter.py::test_param_infer_default
				test/test_inference/test_compiled.py::test_next_docstr
				test/test_inference/test_compiled.py::test_time_docstring
				test/test_inference/test_gradual/test_typeshed.py::test_module_exists_only_as_stub
			)
			;;
		python3.14*)
			EPYTEST_DESELECT+=(
				# type annotation printing difference
				test/test_inference/test_mixed.py::test_compiled_signature_annotation_string
				# extra attributes in os
				test/test_utils.py::TestSetupReadline::test_import
			)
			;;
	esac

	# some plugin breaks case-insensitivity on completions
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	# django and pytest tests are very version dependent
	epytest -o addopts= -k "not django and not pytest"
}
