# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( python3_{11..14} pypy3_11 )
PYTHON_REQ_USE="threads(+)"

inherit distutils-r1

MY_P=${P/_}
DESCRIPTION="Python documentation generator"
HOMEPAGE="
	https://www.sphinx-doc.org/
	https://github.com/sphinx-doc/sphinx/
	https://pypi.org/project/Sphinx/
"
SRC_URI="
	https://github.com/sphinx-doc/sphinx/archive/v${PV/_}.tar.gz
		-> ${MY_P}.gh.tar.gz
"
S=${WORKDIR}/${MY_P}

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="doc latex"

RDEPEND="
	>=dev-python/alabaster-0.7.14[${PYTHON_USEDEP}]
	>=dev-python/babel-2.13[${PYTHON_USEDEP}]
	<dev-py/docutils-0.22[${PYTHON_USEDEP}]
	>=dev-py/docutils-0.20[${PYTHON_USEDEP}]
	>=dev-python/imagesize-1.3[${PYTHON_USEDEP}]
	>=dev-py/jinja-3.1[${PYTHON_USEDEP}]
	>=dev-python/packaging-23.0[${PYTHON_USEDEP}]
	>=dev-python/pygments-2.14[${PYTHON_USEDEP}]
	>=dev-python/requests-2.30.0[${PYTHON_USEDEP}]
	>=dev-python/roman-numerals-py-1.0.0[${PYTHON_USEDEP}]
	>=dev-python/snowballstemmer-2.2[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-applehelp-1.0.7[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-devhelp-1.0.6[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-htmlhelp-2.0.6[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-jsmath-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-qthelp-1.0.6[${PYTHON_USEDEP}]
	>=dev-python/sphinxcontrib-serializinghtml-1.1.9[${PYTHON_USEDEP}]
	latex? (
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-luatex
		app-text/dvipng
	)
"
BDEPEND="
	>=dev-python/flit-core-3.11
	doc? (
		dev-python/sphinxcontrib-websupport[${PYTHON_USEDEP}]
		media-gfx/graphviz
	)
	test? (
		app-text/dvipng
		>=dev-py/cython-3.0.0[${PYTHON_USEDEP}]
		>=dev-python/defusedxml-0.7.1[${PYTHON_USEDEP}]
		dev-python/pytest-rerunfailures[${PYTHON_USEDEP}]
		>=dev-py/setuptools-67.0[${PYTHON_USEDEP}]
		dev-texlive/texlive-fontsextra
		dev-texlive/texlive-latexextra
		dev-texlive/texlive-luatex
		virtual/imagemagick-tools[jpeg,png,svg]
	)
"

PATCHES=(
	"${FILESDIR}/sphinx-3.2.1-doc-link.patch"
	"${FILESDIR}/${P}-fix-python3.14.patch" # patch collection, merged upstream
)

distutils_enable_tests pytest

python_prepare_all() {
	# disable internet access
	sed -i -e 's:^intersphinx_mapping:disabled_&:' \
		doc/conf.py || die

	distutils-r1_python_prepare_all
}

python_compile_all() {
	# we can't use distutils_enable_sphinx because it would
	# introduce a dep on itself
	use doc && build_sphinx doc
}

python_test() {
	mkdir -p "${BUILD_DIR}/sphinx_tempdir" || die
	local -x SPHINX_TEST_TEMPDIR="${BUILD_DIR}/sphinx_tempdir"

	local EPYTEST_DESELECT=(
		# less interesting failures
		tests/test_builders/test_build_latex.py::test_build_latex_doc
		tests/test_extensions/test_ext_math.py::test_imgmath_png
		tests/test_extensions/test_ext_math.py::test_imgmath_numfig_html
	)
	case ${EPYTHON} in
		pypy3.11)
			EPYTEST_DESELECT+=(
				# TODO
				tests/test_util/test_util_inspect.py::test_is_classmethod_descriptor
				tests/test_util/test_util_inspect.py::test_is_builtin_classmethod_like
				# minor repr() differences
				tests/test_util/test_util_typing.py::test_restify
				tests/test_util/test_util_typing.py::test_stringify_annotation
				tests/test_util/test_util_typing.py::test_stringify_type_union_operator
				# from pypy3 era
				tests/test_extensions/test_ext_autodoc.py::test_autodoc_exception
				tests/test_extensions/test_ext_autodoc.py::test_autodoc_ignore_module_all
				tests/test_extensions/test_ext_autodoc.py::test_autodoc_inherited_members_None
				tests/test_extensions/test_ext_autodoc.py::test_autodoc_subclass_of_builtin_class
				tests/test_extensions/test_ext_autodoc.py::test_automethod_for_builtin
				tests/test_extensions/test_ext_autodoc.py::test_cython
				tests/test_extensions/test_ext_autodoc.py::test_format_signature
				tests/test_extensions/test_ext_autodoc.py::test_partialfunction
				tests/test_extensions/test_ext_autodoc_autoclass.py::test_autodoc_process_bases
				tests/test_extensions/test_ext_autodoc_autoclass.py::test_show_inheritance_for_decendants_of_generic_type
				tests/test_extensions/test_ext_autodoc_autoclass.py::test_show_inheritance_for_subclass_of_generic_type
				tests/test_extensions/test_ext_autodoc_autofunction.py::test_builtin_function
				tests/test_extensions/test_ext_autodoc_autofunction.py::test_methoddescriptor
				tests/test_extensions/test_ext_autodoc_automodule.py::test_automodule_inherited_members
				tests/test_extensions/test_ext_autodoc_preserve_defaults.py::test_preserve_defaults_special_constructs
				tests/test_extensions/test_ext_autosummary.py::test_autosummary_generate_content_for_module
				tests/test_extensions/test_ext_autosummary.py::test_autosummary_generate_content_for_module_skipped
				tests/test_util/test_util_inspect.py::test_isattributedescriptor
				tests/test_util/test_util_inspect.py::test_signature
				tests/test_util/test_util_typing.py::test_is_invalid_builtin_class
			)
			;;
	esac

	# note: pytest-xdist causes random test failures
	local -x PYTEST_DISABLE_PLUGIN_AUTOLOAD=1
	epytest -p rerunfailures --reruns=5
}
