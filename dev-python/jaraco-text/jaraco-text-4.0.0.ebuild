# Distributed under the terms of the GNU General Public License v2

# please keep this ebuild at EAPI 8 -- sys-apps/portage dep
EAPI=8

DISTUTILS_USE_PEP517=flit
PYPI_PN=${PN/-/.}
PYTHON_COMPAT=( python3_{11..14} python3_{13,14}t pypy3_11 )

inherit distutils-r1 pypi

DESCRIPTION="Text utilities used by other projects by developer jaraco"
HOMEPAGE="
	https://github.com/jaraco/jaraco.text/
	https://pypi.org/project/jaraco.text/
"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	>=dev-python/jaraco-context-4.1.1-r1[${PYTHON_USEDEP}]
	>=dev-python/jaraco-functools-3.5.0-r1[${PYTHON_USEDEP}]
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
		name = "jaraco.text"
		version = "${PV}"
		description = "Module for text manipulation"
	EOF

	# remove CLI tools, they have annoying deps, no entry points
	# and since there are dashes in their names, they can't be imported
	# anyway
	rm jaraco/text/*-*.py || die
}

python_install() {
	distutils-r1_python_install
	# rename to workaround a bug in pkg_resources
	# https://bugs.gentoo.org/834522
	mv "${D}$(python_get_sitedir)"/jaraco{_,.}text-${PV}.dist-info || die
}
