# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs flag-o-matic

MY_P="${P/_/-}"

DESCRIPTION="The GNU Privacy Guard, a GPL OpenPGP implementation"
HOMEPAGE="http://www.gnupg.org/"
SRC_URI="mirror://gnupg/gnupg/${MY_P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 ldap nls readline +gnutls tools"

COMMON_DEPEND_LIBS="
	>=lib-dev/npth-1.2
	>=lib-dev/libassuan-2.5.0
	>=lib-dev/libgcrypt-1.7.3
	>=lib-dev/libgpg-error-1.24
	>=lib-dev/libksba-1.3.4
	>=app-net/curl-7.10
	>=lib-net/gnutls-3.0:0=
	lib-sys/zlib
	ldap? ( app-net/openldap )
	bzip2? ( app-compression/lbzip2 )
	readline? ( lib-sys/readline:0= )
"

COMMON_DEPEND_BINS="app-crypt/pinentry"

# Existence of executables is checked during configuration.
DEPEND="${COMMON_DEPEND_LIBS}
	${COMMON_DEPEND_BINS}
	nls? ( sys-devel/gettext )"

RDEPEND="${COMMON_DEPEND_LIBS}
	${COMMON_DEPEND_BINS}
	nls? ( sys-devel/gettext )"

S="${WORKDIR}/${MY_P}"

append-flags -fno-strict-aliasing

src_configure() {
	local myconf=(
			$(use_enable bzip2)
			$(use_enable gnutls)
			$(use_enable nls)
			$(use_with ldap)
			$(use_with readline)
			--enable-symcryptrun
			--enable-gpg
			--enable-gpgsm
			--enable-large-secmem
			--enable-all-tests
			--disable-scdaemon
			--disable-tofu
			--disable-wks-tools
		)

	# glib fails and picks up clang's internal stdint.h causing weird errors
	[[ ${CC} == *clang ]] && \
		export gl_cv_absolute_stdint_h=/usr/include/stdint.h

	econf \
		"${myconf[@]}" CC_FOR_BUILD="$(tc-getBUILD_CC)"
}

src_install() {
	default

	use tools &&
		dobin \
			tools/{convert-from-106,gpg-check-pattern} \
			tools/{gpg-zip,gpgconf,gpgsplit,lspgpot,mail-signed-keys} \
			tools/make-dns-cert

	dosym gpg /usr/bin/gpg2
	dosym gpgv /usr/bin/gpgv2
	echo ".so man1/gpg.1" > "${ED}"/usr/share/man/man1/gpg2.1 || die
	echo ".so man1/gpgv.1" > "${ED}"/usr/share/man/man1/gpgv2.1 || die

	dodir /etc/env.d
	echo "CONFIG_PROTECT=/usr/share/gnupg/qualified.txt" >> "${ED}"/etc/env.d/30gnupg || die
}
