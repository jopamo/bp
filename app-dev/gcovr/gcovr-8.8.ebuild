# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517="hatchling"
PYTHON_COMPAT=( python3_{11..14} )

inherit toolchain-funcs distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/colorlog
	dev-pypi/jinja
	dev-pypi/lxml
	dev-pypi/pygments
"
# lockstep-pypi-deps: end
DESCRIPTION="A Python script for summarizing gcov data"
HOMEPAGE="https://github.com/gcovr/gcovr"
SRC_URI="https://github.com/gcovr/gcovr/archive/${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	dev-pypi/jinja[${PYTHON_USEDEP}]
	dev-pypi/lxml[${PYTHON_USEDEP}]
	dev-pypi/colorlog[${PYTHON_USEDEP}]
	>=dev-pypi/pygments-2.13.0[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		dev-pypi/pytest-timeout[${PYTHON_USEDEP}]
		dev-pypi/yaxmldiff[${PYTHON_USEDEP}]
		dev-pypi/pytest-check[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

_gcovr_write_static_pyproject() {
	"${EPYTHON}" - <<-'PY' || die "failed to write a static pyproject.toml for hatchling"
	import os
	import textwrap
	from pathlib import Path

	Path("pyproject.toml").write_text(
	    textwrap.dedent(
	        f"""\
	        [build-system]
	        requires = ["hatchling==1.27.0"]
	        build-backend = "hatchling.build"

	        [project]
	        name = "gcovr"
	        version = "{os.environ["PV"]}"
	        readme = "README.rst"
	        license = "BSD-3-Clause"
	        description = "Generate C/C++ code coverage reports with gcov"
	        requires-python = ">=3.10"
	        dependencies = [
	            "jinja2",
	            "lxml",
	            "colorlog",
	            "pygments>=2.13.0",
	            "tomli >= 1.1.0 ; python_version < '3.11'",
	        ]

	        [project.scripts]
	        gcovr = "gcovr.__main__:main"

	        [tool.hatch.build]
		        artifacts = ["src/gcovr/version.py"]

		        [tool.hatch.build.targets.wheel]
	        packages = ["src/gcovr"]

	        [tool.hatch.build.targets.sdist]
	        include = ["src/gcovr/"]
	        """
	    ),
	    encoding="utf-8",
	)
	Path("src/gcovr/version.py").write_text(
	    f'__version__ = "{os.environ["PV"]}"\n',
	    encoding="utf-8",
	)
	PY
}

python_prepare_all() {
	python_setup "${DISTUTILS_ALL_SUBPHASE_IMPLS[@]}"

	_gcovr_write_static_pyproject

	distutils-r1_python_prepare_all

	local reference source target
	local -a references=(
		"tests/decisions/reference/decisions/clang-12/coverage_summary.json:tests/decisions/reference/decisions/clang-23-libcxx/coverage_summary.json"
		"tests/decisions/reference/decisions/clang-18/coverage.json:tests/decisions/reference/decisions/clang-23-libcxx/coverage.json"
		"tests/decisions/reference/decisions/clang-12/coverage.functions.html:tests/decisions/reference/decisions/clang-23-libcxx/coverage.functions.html"
		"tests/decisions/reference/decisions/clang-12/coverage.html:tests/decisions/reference/decisions/clang-23-libcxx/coverage.html"
		"tests/decisions/reference/decisions/clang-12/coverage.switch_test.cpp.f9d04ab32823b132a649349d5b0d4f03.html:tests/decisions/reference/decisions/clang-23-libcxx/coverage.switch_test.cpp.f9d04ab32823b132a649349d5b0d4f03.html"
		"tests/decisions/reference/decisions/clang-12/coverage_summary.txt:tests/decisions/reference/decisions/clang-23-libcxx/coverage_summary.txt"
		"tests/decisions/reference/decisions/clang-12/coverage_uncovered_summary.txt:tests/decisions/reference/decisions/clang-23-libcxx/coverage_uncovered_summary.txt"
		"tests/decisions/reference/decisions-neg-delta/clang-12/coverage.json:tests/decisions/reference/decisions-neg-delta/clang-23-libcxx/coverage.json"
		"tests/decisions/reference/decisions-neg-delta/clang-10/coverage.html:tests/decisions/reference/decisions-neg-delta/clang-23-libcxx/coverage.html"
		"tests/decisions/reference/decisions-neg-delta/clang-12/coverage.functions.html:tests/decisions/reference/decisions-neg-delta/clang-23-libcxx/coverage.functions.html"
		"tests/decisions/reference/decisions-neg-delta/clang-12/coverage.main.cpp.118fcbaaba162ba17933c7893247df3a.html:tests/decisions/reference/decisions-neg-delta/clang-23-libcxx/coverage.main.cpp.118fcbaaba162ba17933c7893247df3a.html"
		"tests/noncode/reference/clang-18/coverage.json:tests/noncode/reference/clang-23-libcxx/coverage.json"
	)
	for reference in "${references[@]}"; do
		source=${reference%%:*}
		target=${reference#*:}
		mkdir -p "${target%/*}" || die
		cp "${source}" "${target}" || die
	done
	eapply "${FILESDIR}/clang23-libcxx-references.patch"
}

python_compile() {
	_gcovr_write_static_pyproject
	distutils-r1_python_compile
}

python_test() {
	local -x CC="$(tc-getCC)"
	[[ ${CC##*/} == cc ]] && CC="$(tc-get-compiler-type)"
	local -x GCOVR_TEST_SUITE=1 GCOVR_TEST_SUITE_NO_GIT_COMMAND=1
	local -x SOURCE_DATE_EPOCH=1793099975
	epytest --timeout=120 tests
}

PATCHES=( "${FILESDIR}/native-reports.patch" )
