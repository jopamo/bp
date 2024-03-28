# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_NO_NORMALIZE=1
PYTHON_COMPAT=( pypy3 python3_{10..12} )

inherit distutils-r1 pypi

DESCRIPTION="Canonical source for classifiers on PyPI (pypi.org)"
HOMEPAGE="
	https://github.com/pypa/trove-classifiers/
	https://pypi.org/project/trove-classifiers/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 arm64"

distutils_enable_tests pytest

src_configure() {
	grep -q 'build-backend = "setuptools' pyproject.toml ||
		die "Upstream changed build-backend, recheck"
	# write a custom pyproject.toml to ease hatchling bootstrap
	cat > pyproject.toml <<-EOF || die
		[build-system]
		requires = ["flit_core >=3.2,<4"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "trove-classifiers"
		version = "${PV}"
		description = "Canonical source for classifiers on PyPI (pypi.org)."
	EOF
}

python_test() {
	epytest
	"${EPYTHON}" -m tests.lib || die
}
