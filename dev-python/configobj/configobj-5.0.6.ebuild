# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit distutils-r1

DESCRIPTION="Simple config file reader and writer"
HOMEPAGE="http://www.voidspace.org.uk/python/configobj.html https://pypi.org/project/configobj/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="dev-python/six[${PYTHON_USEDEP}]"

python_prepare_all() {
	# Not to install un-needed _version.py
	sed -e "/^MODULES =/s/, '_version'//" -i setup.py || die
	sed \
		-e "s/^from _version import __version__$/__version__ = '${PV}'/" \
		-i configobj.py || die

	distutils-r1_python_prepare_all
}

python_test() {
	"${PYTHON}" validate.py -v || die "Tests fail with ${EPYTHON}"
}
