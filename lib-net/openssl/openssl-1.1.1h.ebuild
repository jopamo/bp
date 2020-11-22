# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic toolchain-funcs

MY_P=${P/_/-}

DESCRIPTION="full-strength general purpose cryptography library (including SSL and TLS)"
HOMEPAGE="https://www.openssl.org/"
SRC_URI="ftp://ftp.pca.dfn.de/pub/tools/net/openssl/source/${MY_P}.tar.gz"

LICENSE="openssl"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+asm rfc3779 static-libs test zlib"

RESTRICT="!test? ( test )"

RDEPEND=">=app-misc/c_rehash-1.7-r1
	zlib? ( >=lib-sys/zlib-1.2.8-r1[static-libs(+)?] )"
DEPEND="${RDEPEND}"
BDEPEND="
	>=dev-lang/perl-5
	test? (
		sys-app/diffutils
		sys-devel/bc
		sys-app/procps
	)"
PDEPEND="app-misc/ca-certificates"

PATCHES=(
	"${FILESDIR}"/${PN}-1.1.0j-parallel_install_fix.patch #671602
)

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# keep this in sync with app-misc/c_rehash
	SSL_CNF_DIR="/etc/ssl"

	# Make sure we only ever touch Makefile.org and avoid patching a file
	# that gets blown away anyways by the Configure script in src_configure
	rm -f Makefile

	eapply_user #332661

	# make sure the man pages are suffixed #302165
	# don't bother building man pages if they're disabled
	# Make DOCDIR Gentoo compliant
	sed -i \
		-e '/^MANSUFFIX/s:=.*:=ssl:' \
		-e '/^MAKEDEPPROG/s:=.*:=$(CC):' \
		-e $(has noman FEATURES \
			&& echo '/^install:/s:install_docs::' \
			|| echo '/^MANDIR=/s:=.*:='${EPREFIX}'/usr/share/man:') \
		-e "/^DOCDIR/s@\$(BASENAME)@&-${PVR}@" \
		Configurations/unix-Makefile.tmpl \
		|| die

	# quiet out unknown driver argument warnings since openssl
	# doesn't have well-split CFLAGS and we're making it even worse
	# and 'make depend' uses -Werror for added fun (#417795 again)
	[[ ${CC} == *clang* ]] && append-flags -Qunused-arguments

	append-flags -fno-strict-aliasing
	append-flags $(test-flags-CC -Wa,--noexecstack)
	append-cppflags -DOPENSSL_NO_BUF_FREELISTS

	# Prefixify Configure shebang (#141906)
	sed \
		-e "1s,/usr/bin/env,${EPREFIX}&," \
		-i Configure || die
	# Remove test target when FEATURES=test isn't set
	if ! use test ; then
		sed \
			-e '/^$config{dirs}/s@ "test",@@' \
			-i Configure || die
	fi
	# The config script does stupid stuff to prompt the user.  Kill it.
	sed -i '/stty -icanon min 0 time 50; read waste/d' config || die
	./config --test-sanity || die "I AM NOT SANE"
}

src_configure() {
	unset APPS #197996
	unset SCRIPTS #312551
	unset CROSS_COMPILE #311473

	tc-export CC AR RANLIB RC

	# Clean out patent-or-otherwise-encumbered code
	# Camellia: Royalty Free            https://en.wikipedia.org/wiki/Camellia_(cipher)
	# IDEA:     Expired                 https://en.wikipedia.org/wiki/International_Data_Encryption_Algorithm
	# EC:       ????????? ??/??/2015    https://en.wikipedia.org/wiki/Elliptic_Curve_Cryptography
	# MDC2:     Expired                 https://en.wikipedia.org/wiki/MDC-2
	# RC5:      Expired                 https://en.wikipedia.org/wiki/RC5

	use_ssl() { usex $1 "enable-${2:-$1}" "no-${2:-$1}" " ${*:3}" ; }
	echoit() { echo "$@" ; "$@" ; }

	local krb5=$(has_version app-crypt/mit-krb5 && echo "MIT" || echo "Heimdal")

	local sslout=$(./gentoo.config)
	einfo "Use configuration ${sslout:-(openssl knows best)}"
	local config="Configure"
	[[ -z ${sslout} ]] && config="config"

	# Fedora hobbled-EC needs 'no-ec2m'
	# 'srp' was restricted until early 2017 as well.
	# "disable-deprecated" option breaks too many consumers.
	# Don't set it without thorough revdeps testing.
	# Make sure user flags don't get added *yet* to avoid duplicated
	# flags.
	CFLAGS= LDFLAGS= echoit \
	./${config} \
		${sslout} \
		enable-camellia \
		enable-ec \
		enable-srp \
		${ec_nistp_64_gcc_128} \
		enable-idea \
		enable-mdc2 \
		enable-rc5 \
		disable-ssl3 \
		disable-ssl3-method \
		$(use_ssl asm) \
		$(use_ssl rfc3779) \
		disable-heartbeats \
		$(use_ssl zlib) \
		--prefix="${EPREFIX}"/usr \
		--openssldir="${EPREFIX}"${SSL_CNF_DIR} \
		shared threads \
		|| die

	# Clean out hardcoded flags that openssl uses
	local DEFAULT_CFLAGS=$(grep ^CFLAGS= Makefile | LC_ALL=C sed \
		-e 's:^CFLAGS=::' \
		-e 's:\(^\| \)-fomit-frame-pointer::g' \
		-e 's:\(^\| \)-O[^ ]*::g' \
		-e 's:\(^\| \)-march=[^ ]*::g' \
		-e 's:\(^\| \)-mcpu=[^ ]*::g' \
		-e 's:\(^\| \)-m[^ ]*::g' \
		-e 's:^ *::' \
		-e 's: *$::' \
		-e 's: \+: :g' \
		-e 's:\\:\\\\:g'
	)

	# Now insert clean default flags with user flags
	sed -i \
		-e "/^CFLAGS=/s|=.*|=${DEFAULT_CFLAGS} ${CFLAGS}|" \
		-e "/^LDFLAGS=/s|=[[:space:]]*$|=${LDFLAGS}|" \
		Makefile || die
}

src_compile() {
	# depend is needed to use $confopts; it also doesn't matter
	# that it's -j1 as the code itself serializes subdirs
	emake -j1 depend
	emake all
}

src_test() {
	emake -j1 test
}

src_install() {
	# We need to create $ED/usr on our own to avoid a race condition #665130
	if [[ ! -d "${ED}/usr" ]]; then
		# We can only create this directory once
		mkdir "${ED}"/usr || die
	fi

	# This is crappy in that the static archives are still built even
	# when USE=static-libs.  But this is due to a failing in the openssl
	# build system: the static archives are built as PIC all the time.
	# Only way around this would be to manually configure+compile openssl
	# twice; once with shared lib support enabled and once without.
	use static-libs || rm -f "${ED}"/usr/lib*/lib*.a

	# create the certs directory
	keepdir ${SSL_CNF_DIR}/certs

	dodir /etc/sandbox.d #254521
	echo 'SANDBOX_PREDICT="/dev/crypto"' > "${ED}"/etc/sandbox.d/10openssl

	diropts -m0700
	keepdir ${SSL_CNF_DIR}/private

	emake DESTDIR="${D}" install

	rm "${ED}"/usr/bin/c_rehash
}

pkg_postinst() {
	ebegin "Running 'c_rehash ${EROOT}${SSL_CNF_DIR}/certs/' to rebuild hashes #333069"
	c_rehash "${EROOT}${SSL_CNF_DIR}/certs" >/dev/null
	eend $?
}
