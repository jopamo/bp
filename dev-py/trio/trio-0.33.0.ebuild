# Distributed under the terms of the GNU General Public License v2

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1
# lockstep-pypi-managed: true
# lockstep-pypi-deps: begin
RDEPEND+="
	dev-pypi/attrs
	dev-pypi/idna
	dev-pypi/outcome
	dev-pypi/sniffio
	dev-pypi/sortedcontainers
"
# lockstep-pypi-deps: end
DESCRIPTION="Python library for async concurrency and I/O"
HOMEPAGE="
	https://github.com/python-trio/trio/
	https://pypi.org/project/trio/
"
SRC_URI="
	https://github.com/python-trio/${PN}/archive/v${PV}.tar.gz
		-> ${P}.gh.tar.gz
"

LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-py/attrs-23.2.0[${PYTHON_USEDEP}]
	dev-py/idna[${PYTHON_USEDEP}]
	dev-py/outcome[${PYTHON_USEDEP}]
	>=dev-py/sniffio-1.3.0[${PYTHON_USEDEP}]
	dev-py/sortedcontainers[${PYTHON_USEDEP}]
"
BDEPEND="
	test? (
		>=dev-py/astor-0.8.0[${PYTHON_USEDEP}]
		>=dev-py/immutables-0.6[${PYTHON_USEDEP}]
		dev-py/pyopenssl[${PYTHON_USEDEP}]
		dev-py/trustme[${PYTHON_USEDEP}]
	)
"

EPYTEST_PLUGINS=( "${PN}" )
# xdist causes import errors
distutils_enable_tests pytest
# Bug https://bugs.gentoo.org/916756
# distutils_enable_sphinx docs/source \
# 	dev-py/immutables \
# 	dev-py/sphinxcontrib-trio \
# 	dev-py/sphinx-rtd-theme \
# 	dev-py/towncrier

python_test() {
	local EPYTEST_DESELECT=(
		# Times out on slower arches (ia64 in this case)
		# https://github.com/python-trio/trio/issues/1753
		tests/test_unix_pipes.py::test_close_at_bad_time_for_send_all
		# requires ruff
		_tests/tools/test_gen_exports.py
	)

	case ${EPYTHON} in
		python3.14)
			EPYTEST_DESELECT+=(
				# xfail-ed upstream with ref to
				# https://github.com/python/cpython/issues/125603
				_core/_tests/test_run.py::test_ki_protection_doesnt_leave_cyclic_garbage
			)
			;;
	esac

	rm -rf trio || die
	epytest -m "not redistributors_should_skip" --pyargs trio \
		--skip-optional-imports
}
