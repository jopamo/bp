# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3_11 python3_{11..14} )

inherit distutils-r1 pypi

DESCRIPTION="Backport of pathlib-compatible object wrapper for zip files"
HOMEPAGE="
	https://github.com/jaraco/zipp/
	https://pypi.org/project/zipp/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

# big_o is only used in test_complexity, that we ignore
BDEPEND="
	test? (
		dev-python/jaraco-functools[${PYTHON_USEDEP}]
		dev-python/jaraco-itertools[${PYTHON_USEDEP}]
		dev-python/jaraco-test[${PYTHON_USEDEP}]
		dev-python/more-itertools[${PYTHON_USEDEP}]
	)
"

distutils_enable_tests pytest

EPYTEST_IGNORE=(
	# performance tests are flaky by design
	tests/test_complexity.py
)

src_configure() {
	grep -q 'build-backend = "setuptools' pyproject.toml ||
		die "Upstream changed build-backend, recheck"
	# write a custom pyproject.toml to ease setuptools bootstrap
	cat > pyproject.toml <<-EOF || die
		[build-system]
		requires = ["flit_core >=3.2,<4"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "zipp"
		version = "${PV}"
		description = "Backport of pathlib-compatible object wrapper for zip files"
	EOF
}
