# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 7 -- sys-apps/portage dep
EAPI=7

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Distribution package dependency inspector"
HOMEPAGE="
	https://github.com/jaraco/nspektr/
	https://pypi.org/project/nspektr/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/jaraco-context-4.1.1-r2[${PYTHON_USEDEP}]
	>=dev-python/jaraco-functools-3.5.0-r2[${PYTHON_USEDEP}]
	>=dev-python/more-itertools-8.12.0-r1[${PYTHON_USEDEP}]
	>=dev-python/packaging-21.3-r2[${PYTHON_USEDEP}]
"

distutils_enable_tests pytest

src_configure() {
	grep -q 'build-backend = "setuptools' pyproject.toml ||
		die "Upstream changed build-backend, recheck"
	# write a custom pyproject.toml to ease setuptools bootstrap
	cat > pyproject.toml <<-EOF || die
		[build-system]
		requires = ["flit_core >=3.2,<4"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "nspektr"
		version = "${PV}"
		description = "package inspector"

		# tests inspect itself
		[project.optional-dependencies]
		docs = [
			"fake-nonexisting",
		]
		testing = [
			"pytest",
		]
	EOF
}
