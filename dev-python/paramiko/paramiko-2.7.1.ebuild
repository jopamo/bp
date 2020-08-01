# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit distutils-r1 flag-o-matic

DESCRIPTION="SSH2 protocol library"
HOMEPAGE="http://www.paramiko.org/ https://github.com/paramiko/paramiko/ https://pypi.org/project/paramiko/"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="server test"

RDEPEND="
	>=dev-python/bcrypt-3.1.3[${PYTHON_USEDEP}]
	>=dev-python/cryptography-2.5[${PYTHON_USEDEP}]
	>=dev-python/pynacl-1.0.1[${PYTHON_USEDEP}]
	>=dev-python/pyasn1-0.1.7[${PYTHON_USEDEP}]
"
BDEPEND="
	dev-python/setuptools[${PYTHON_USEDEP}]
	test? (
		dev-python/mock[${PYTHON_USEDEP}]
		dev-python/pytest[${PYTHON_USEDEP}]
	)
"

filter-flags -Wl,-z,defs

src_prepare() {
	eapply "${FILESDIR}"/${PN}-tests.patch

	if ! use server; then
		eapply "${FILESDIR}/${PN}-2.4.2-disable-server.patch"
	fi

	eapply_user
}

python_test() {
	py.test -v || die "Tests fail with ${EPYTHON}"
}
