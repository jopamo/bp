# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh2.org/"

SNAPSHOT=7e1c6be12feefe4913733584a9aacb03c80c045a
SRC_URI="https://github.com/libssh2/libssh2/archive/${SNAPSHOT}.tar.gz -> libssh2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libssh2-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gcrypt static-libs test zlib"

DEPEND="
	!gcrypt? ( virtual/ssl )
	gcrypt? ( >=lib-core/libgcrypt-1.5.3:0 )
	zlib? ( >=lib-core/zlib-1.2.8-r1 )
"
RDEPEND="${DEPEND}"

src_prepare() {
	default

	sed -i -e 's|mansyntax.sh||g' tests/Makefile.am || die
	ln -s ../src/libssh2_config.h.in example/libssh2_config.h.in || die

	eautoreconf
}

src_configure() {
	# Disable tests that require extra permissions (bug #333319)
	use test && local -x ac_cv_path_SSHD=

	local crypto
	if use gcrypt; then
		crypto=libgcrypt
	else
		crypto=openssl
	fi

	ECONF_SOURCE="${S}" econf --with-crypto=${crypto}
}

src_install() {
	default
	use static-libs || find "${ED}" -name '*.a' -delete
}
