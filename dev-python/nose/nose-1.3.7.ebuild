# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1

DESCRIPTION="Unittest extension with automatic test suite discovery and easy test authoring"
HOMEPAGE="
	https://pypi.org/project/nose/
	https://nose.readthedocs.io/en/latest/
	https://github.com/nose-devs/nose"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

python_prepare_all() {
	# Disable tests requiring network connection.
	sed \
		-e "s/test_resolve/_&/g" \
		-e "s/test_raises_bad_return/_&/g" \
		-e "s/test_raises_twisted_error/_&/g" \
		-i unit_tests/test_twisted.py || die "sed failed"
	# Disable versioning of nosetests script to avoid collision with
	# versioning performed by the eclass.
	sed -e "/'nosetests%s = nose:run_exit' % py_vers_tag,/d" \
		-i setup.py || die "sed2 failed"

	# Prevent un-needed d'loading during doc build
	sed -e "s/, 'sphinx.ext.intersphinx'//" -i doc/conf.py || die

	distutils-r1_python_prepare_all
}

python_install() {
	distutils-r1_python_install --install-data "${EPREFIX}/usr/share"
}
