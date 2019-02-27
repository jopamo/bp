# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils flag-o-matic toolchain-funcs git-r3

DESCRIPTION="full-strength general purpose cryptography library (including SSL and TLS)"
HOMEPAGE="https://www.openssl.org/"
EGIT_REPO_URI="https://github.com/openssl/openssl.git"
EGIT_BRANCH="OpenSSL_1_1_0-stable"
#KEYWORDS="amd64 arm64"

LICENSE="openssl"
SLOT="0"
IUSE="+asm bindist rfc3779 sctp static-libs test vanilla zlib"
RESTRICT="!bindist? ( bindist )"

RDEPEND="zlib? ( >=lib-sys/zlib-1.2.8-r1[static-libs(+)?] )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sctp? ( >=app-net/lksctp-tools-1.0.12 )
	test? (
		sys-app/diffutils
		sys-devel/bc
	)"
PDEPEND="app-misc/ca-certificates"

src_prepare() {
	SSL_CNF_DIR="/etc/ssl"
	rm -f Makefile

	eapply_user

	# show the actual commands in the log
	sed -i '/^SET_X/s:=.*:=set -x:' Makefile.shared

	append-flags -Wunused-parameter

	append-flags -fno-strict-aliasing
	append-flags $(test-flags-CC -Wa,--noexecstack)
	append-cppflags -DOPENSSL_NO_BUF_FREELISTS

	sed -i '1s,^:$,#!'${EPREFIX}'/usr/bin/perl,' Configure #141906
	sed -i '/stty -icanon min 0 time 50; read waste/d' config || die
	./config --test-sanity || die "I AM NOT SANE"
}

src_configure() {
	unset APPS
	unset SCRIPTS
	unset CROSS_COMPILE

	tc-export CC AR RANLIB RC

	use_ssl() { usex $1 "enable-${2:-$1}" "no-${2:-$1}" " ${*:3}" ; }
	echoit() { echo "$@" ; "$@" ; }

	local ec_nistp_64_gcc_128

	echoit \
	${S}/config \
		no-deprecated \
		--prefix="${EPREFIX}"/usr \
		--openssldir="${EPREFIX}"${SSL_CNF_DIR} \
		--libdir=lib64 \
		shared zlib-dynamic \
		|| die

	# Clean out hardcoded flags that openssl uses
	# Fix quoting for sed
	local DEFAULT_CFLAGS=$(grep ^CFLAGS= Makefile | LC_ALL=C sed \
		-e 's:^CFLAGS=::' \
		-e 's:-fomit-frame-pointer ::g' \
		-e 's:-O[0-9] ::g' \
		-e 's:-march=[-a-z0-9]* ::g' \
		-e 's:-mcpu=[-a-z0-9]* ::g' \
		-e 's:-m[a-z0-9]* ::g' \
		-e 's:\\:\\\\:g' \
	)
	sed -i \
		-e "/^CFLAGS=/s|=.*|=${DEFAULT_CFLAGS} ${CFLAGS}|" \
		-e "/^LDFLAGS=/s|=[[:space:]]*$|=${LDFLAGS}|" \
		Makefile || die
}

src_compile() {
	emake all
}

src_test() {
	emake -j1 test
}

src_install() {
	emake DESTDIR="${D}" install
}

src_install_all() {
	use static-libs || rm -f "${ED}"/usr/lib*/lib*.a

	keepdir ${SSL_CNF_DIR}/certs

	dodir /etc/sandbox.d #254521
	echo 'SANDBOX_PREDICT="/dev/crypto"' > "${ED}"/etc/sandbox.d/10openssl

	diropts -m0700
	keepdir ${SSL_CNF_DIR}/private
	rm -rf ${ED}/usr/share/doc
}

pkg_postinst() {
	ebegin "Rehashing certs in '${EROOT%/}${SSL_CNF_DIR}/certs/'"
	c_rehash "${EROOT%/}${SSL_CNF_DIR}/certs" >/dev/null
	eend $?
}
