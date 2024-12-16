# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic

MY_P="${P/_/-}"

DESCRIPTION="The GNU Privacy Guard, a GPL OpenPGP implementation"
HOMEPAGE="http://www.gnupg.org/"

SRC_URI="mirror://gnupg/gnupg/${MY_P}.tar.bz2"
S="${WORKDIR}/${MY_P}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="bzip2 ldap readline +gnutls tools"

DEPEND="
	app-crypto/pinentry
	app-net/curl
	lib-core/libassuan
	lib-core/libgcrypt
	lib-core/libgpg-error
	lib-core/libksba
	lib-core/npth
	lib-core/zlib
	lib-net/gnutls
	bzip2? ( app-compression/bzip2 )
	ldap? ( app-net/openldap )
	readline? ( lib-core/readline )
"

src_prepare() {
	default
	sed -e '/ks_ldap_free_state/i #if USE_LDAP' \
    	-e '/ks_get_state =/a #endif' \
    	-i dirmngr/server.c

	touch doc/gnupg.7.html
}
src_configure() {
	local myconf=(
			$(use_enable bzip2)
			$(use_enable gnutls)
			$(use_with ldap)
			$(use_with readline)
			--disable-nls
			--disable-scdaemon
			--disable-sqlite
			--disable-tofu
			--disable-wks-tools
			--enable-all-tests
			--enable-gpgsm
			--enable-large-secmem
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

	dosym gpg usr/bin/gpg2
	dosym gpgv usr/bin/gpgv2
	echo ".so man1/gpg.1" > "${ED}"/usr/share/man/man1/gpg2.1 || die
	echo ".so man1/gpgv.1" > "${ED}"/usr/share/man/man1/gpgv2.1 || die

	cat > "${T}"/30${PN} <<- EOF || die
		CONFIG_PROTECT=/usr/share/gnupg/qualified.txt
	EOF
	doenvd "${T}"/30${PN}
}
