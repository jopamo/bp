# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic autotools

DESCRIPTION="The GNU Privacy Guard, a GPL OpenPGP implementation"
HOMEPAGE="http://www.gnupg.org/"

SNAPSHOT=e212308ede8ecaa3a39ed0366db70da3edfc0ba2
SRC_URI="https://github.com/gpg/gnupg/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

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

	eautoreconf
}

src_configure() {
	local myconf=(
			--disable-card-support
			--disable-ccid-driver
			--disable-dirmngr
			--disable-doc
			--disable-gpgsm
			--disable-gpgtar
			--disable-keyboxd
			--disable-ldap
			--disable-nls
			--disable-nls
			--disable-photo-viewers
			--disable-scdaemon
			--disable-sqlite
			--disable-tofu
			--disable-tpm2d
			--disable-wks-tools
			--enable-all-tests
			--enable-large-secmem
			--enable-maintainer-mode
			$(use_enable bzip2)
			$(use_enable gnutls)
			$(use_with ldap)
			$(use_with readline)
		)

	# glib fails and picks up clang's internal stdint.h causing weird errors
	[[ ${CC} == *clang ]] && \
		export gl_cv_absolute_stdint_h=/usr/include/stdint.h

	econf \
		"${myconf[@]}" CC_FOR_BUILD="$(tc-getBUILD_CC)"
}

src_install() {
	default

	cat > "${T}"/30${PN} <<- EOF || die
		CONFIG_PROTECT=/usr/share/gnupg/qualified.txt
	EOF
	doenvd "${T}"/30${PN}
}
