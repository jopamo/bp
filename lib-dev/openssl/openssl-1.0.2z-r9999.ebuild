# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils flag-o-matic toolchain-funcs git-r3

DESCRIPTION="full-strength general purpose cryptography library (including SSL and TLS)"
HOMEPAGE="https://www.openssl.org/"
EGIT_REPO_URI="https://github.com/openssl/openssl.git"
EGIT_BRANCH="OpenSSL_1_0_2-stable"
KEYWORDS="amd64 arm64"

LICENSE="openssl"
SLOT="0"
IUSE="+asm bindist gmp rfc3779 sctp static-libs test vanilla zlib"
RESTRICT="!bindist? ( bindist )"

RDEPEND="gmp? ( >=lib-dev/gmp-5.1.3-r1[static-libs(+)?] )
	zlib? ( >=lib-sys/zlib-1.2.8-r1[static-libs(+)?] )"

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

	sed -i \
		-e '/DIRS/s: fips : :g' \
		-e '/^MANSUFFIX/s:=.*:=ssl:' \
		-e '/^MAKEDEPPROG/s:=.*:=$(CC):' \
		-e $(has noman FEATURES \
			&& echo '/^install:/s:install_docs::' \
			|| echo '/^MANDIR=/s:=.*:='${EPREFIX}'/usr/share/man:') \
		Makefile.org \
		|| die
	# show the actual commands in the log
	sed -i '/^SET_X/s:=.*:=set -x:' Makefile.shared

	sed -i 's/expr.*MAKEDEPEND.*;/true;/' util/domd || die

	[[ ${CC} == *clang* ]] && append-flags -Qunused-arguments

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

	local krb5=$(has_version app-crypt/mit-krb5 && echo "MIT" || echo "Heimdal")

	local ec_nistp_64_gcc_128

	echoit \
	${S}/config \
		${sslout} \
		enable-camellia \
		$(use_ssl !bindist ec) \
		${ec_nistp_64_gcc_128} \
		enable-idea \
		enable-mdc2 \
		enable-rc5 \
		enable-tlsext \
		$(use_ssl asm) \
		$(use_ssl gmp gmp -lgmp) \
		$(use_ssl rfc3779) \
		$(use_ssl sctp) \
		-DOPENSSL_NO_SSL2 \
		-DOPENSSL_NO_SSL3 \
		-DOPENSSL_NO_HEARTBEATS \
		$(use_ssl zlib) \
		--prefix="${EPREFIX}"/usr \
		--openssldir="${EPREFIX}"${SSL_CNF_DIR} \
		--libdir=lib64 \
		shared threads \
		|| die

	# Clean out hardcoded flags that openssl uses
	local CFLAG=$(grep ^CFLAG= Makefile | LC_ALL=C sed \
		-e 's:^CFLAG=::' \
		-e 's:-fomit-frame-pointer ::g' \
		-e 's:-O[0-9] ::g' \
		-e 's:-march=[-a-z0-9]* ::g' \
		-e 's:-mcpu=[-a-z0-9]* ::g' \
		-e 's:-m[a-z0-9]* ::g' \
	)
	sed -i \
		-e "/^CFLAG/s|=.*|=${CFLAG} ${CFLAGS}|" \
		-e "/^SHARED_LDFLAGS=/s|$| ${LDFLAGS}|" \
		Makefile || die
}

src_compile() {
	# depend is needed to use $confopts; it also doesn't matter
	# that it's -j1 as the code itself serializes subdirs
	make -j1 depend
	emake -j1 all
	# rehash is needed to prep the certs/ dir; do this
	# separately to avoid parallel build issues.
	emake -j1 rehash
}

src_test() {
	emake -j1 test
}

src_install() {
	emake -j1 INSTALL_PREFIX="${D}" install
}

src_install_all() {
	use static-libs || rm -f "${ED}"/usr/lib*/lib*.a

	dodir ${SSL_CNF_DIR}/certs
	cp -RP certs/* "${ED}"${SSL_CNF_DIR}/certs/ || die
	rm -r "${ED}"${SSL_CNF_DIR}/certs/{demo,expired}

	dodir /etc/sandbox.d #254521
	echo 'SANDBOX_PREDICT="/dev/crypto"' > "${ED}"/etc/sandbox.d/10openssl

	diropts -m0700
	keepdir ${SSL_CNF_DIR}/private
}

pkg_postinst() {
	ebegin "Rehashing certs in '${EROOT%/}${SSL_CNF_DIR}/certs/'"
	c_rehash "${EROOT%/}${SSL_CNF_DIR}/certs" >/dev/null
	eend $?
}
