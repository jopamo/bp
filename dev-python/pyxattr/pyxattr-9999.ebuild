# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{6,7,8} )

inherit distutils-r1 eutils git-r3

DESCRIPTION="Python interface to xattr"
HOMEPAGE="http://pyxattr.k1024.org/"
EGIT_REPO_URI="https://github.com/iustin/${PN}.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="test"

RDEPEND="sys-app/attr"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? ( dev-python/nose[${PYTHON_USEDEP}] )"

src_test() {
	export TESTDIR=/var/tmp

	einfo 'Please note that the tests fail if xattrs are not supported'
	einfo 'by the filesystem used for /var/tmp.'
	distutils-r1_src_test
}

python_test() {
	nosetests || die "Tests fail with ${EPYTHON}"
}
