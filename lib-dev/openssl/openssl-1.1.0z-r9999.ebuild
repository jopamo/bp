# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils flag-o-matic toolchain-funcs multilib multilib-minimal git-r3

DESCRIPTION="full-strength general purpose cryptography library (including SSL and TLS)"
HOMEPAGE="https://www.openssl.org/"
EGIT_REPO_URI="https://github.com/openssl/openssl.git"
EGIT_BRANCH="OpenSSL_1_1_0-stable"

LICENSE="openssl"
SLOT="0"
KEYWORDS=""
IUSE="+asm bindist rfc3779 sctp cpu_flags_x86_sse2 static-libs test vanilla zlib"
RESTRICT="!bindist? ( bindist )"

RDEPEND="zlib? ( >=lib-sys/zlib-1.2.8-r1[static-libs(+)?,${MULTILIB_USEDEP}] )"

DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	sctp? ( >=app-net/lksctp-tools-1.0.12 )
	test? (
		sys-app/diffutils
		sys-devel/bc
	)"
PDEPEND="app-misc/ca-certificates"

MULTILIB_WRAPPED_HEADERS=(
	usr/include/openssl/opensslconf.h
)

src_prepare() {
	SSL_CNF_DIR="/etc/ssl"
	rm -f Makefile

	eapply_user

	# show the actual commands in the log
	sed -i '/^SET_X/s:=.*:=set -x:' Makefile.shared

	[[ ${CC} == *clang* ]] && append-flags -Qunused-arguments

	append-flags -fno-strict-aliasing
	append-flags $(test-flags-CC -Wa,--noexecstack)
	append-cppflags -DOPENSSL_NO_BUF_FREELISTS

	sed -i '1s,^:$,#!'${EPREFIX}'/usr/bin/perl,' Configure #141906
	sed -i '/stty -icanon min 0 time 50; read waste/d' config || die
	./config --test-sanity || die "I AM NOT SANE"

	multilib_copy_sources
}

multilib_src_configure() {
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
		$(use cpu_flags_x86_sse2 || echo "no-sse2") \
		enable-camellia \
		$(use_ssl !bindist ec) \
		${ec_nistp_64_gcc_128} \
		enable-idea \
		enable-mdc2 \
		enable-rc5 \
		$(use_ssl asm) \
		$(use_ssl rfc3779) \
		$(use_ssl sctp) \
		-DOPENSSL_NO_SSL2 \
		-DOPENSSL_NO_SSL3 \
		-DOPENSSL_NO_HEARTBEATS \
		$(use_ssl zlib) \
		--prefix="${EPREFIX}"/usr \
		--openssldir="${EPREFIX}"${SSL_CNF_DIR} \
		--libdir=$(get_libdir) \
		shared threads \
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

multilib_src_compile() {
	# depend is needed to use $confopts; it also doesn't matter
	# that it's -j1 as the code itself serializes subdirs
	emake -j1 depend
	emake all
}

multilib_src_test() {
	emake -j1 test
}

multilib_src_install() {
	emake DESTDIR="${D}" install
}

multilib_src_install_all() {
	use static-libs || rm -f "${ED}"/usr/lib*/lib*.a

	keepdir ${SSL_CNF_DIR}/certs

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
