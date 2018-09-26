# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils versionator git-r3

DESCRIPTION="A Python templating language"
HOMEPAGE="http://www.makotemplates.org/ https://pypi.python.org/pypi/Mako"
EGIT_REPO_URI="https://github.com/zzzeek/mako.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64 x86"
IUSE="doc test"

RDEPEND="
	>=dev-python/markupsafe-0.9.2[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/nose[${PYTHON_USEDEP}]
	)"

python_test() {
	nosetests "${S}"/test || die "Tests fail with ${EPYTHON}"
}

python_install_all() {
	rm -rf doc/build || die

	use doc && local HTML_DOCS=( doc/. )
	distutils-r1_python_install_all
}

pkg_postinst() {
	optfeature "Caching support" dev-python/beaker
	for v in ${REPLACING_VERSIONS}; do
		if ! version_is_at_least 0.7.3-r2 $v; then
			ewarn "dev-python/beaker is no longer hard dependency of ${P}"
			ewarn "If you rely on it, you should add beaker to your world"
			ewarn "file:"
			ewarn "# emerge --noreplace beaker"
			break
		fi
	done
}
