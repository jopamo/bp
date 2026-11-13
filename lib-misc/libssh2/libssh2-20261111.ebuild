# Distributed under the terms of the GNU General Public License v2

inherit autotools qa-policy

DESCRIPTION="Library implementing the SSH2 protocol"
HOMEPAGE="http://www.libssh2.org/"
SNAPSHOT=e75fa9a539d21e82d4920c126662e36984e97d61
SRC_URI="https://github.com/libssh2/libssh2/archive/${SNAPSHOT}.tar.gz -> libssh2-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/libssh2-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gcrypt static-libs test zlib"

DEPEND="
	!gcrypt? ( virtual/ssl )
	gcrypt? ( app-crypto/vesk )
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
	local crypto
	if use gcrypt; then
		crypto=libgcrypt
	else
		crypto=openssl
	fi

	qa-policy-configure
	local myconf=(
		--with-crypto=${crypto}
		--disable-docker-tests
		--disable-sshd-tests
	)
	# The standalone test links internal symbols from the static archive.
	if use static-libs || use test; then
		myconf+=( --enable-static )
	else
		myconf+=( --disable-static )
	fi
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}

src_install() {
	default
	qa-policy-install
	use static-libs || find "${ED}" -name '*.a' -delete
}
