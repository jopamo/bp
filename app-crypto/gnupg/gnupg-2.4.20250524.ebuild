# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="STABLE-BRANCH-$(ver_cut 1)-$(ver_cut 2)"

inherit toolchain-funcs flag-o-matic autotools

DESCRIPTION="The GNU Privacy Guard, a GPL OpenPGP implementation"
HOMEPAGE="http://www.gnupg.org/"

SNAPSHOT=57c1c96e7f5c2b94daba5ccc0070cf3ee52d66d9
SRC_URI="https://github.com/gpg/gnupg/archive/${SNAPSHOT}.tar.gz -> gnupg-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gnupg-${SNAPSHOT}"

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
	filter-flags -Wl,-z,defs -flto*

	default

	sed -e '/ks_ldap_free_state/i #if USE_LDAP' \
    	-e '/ks_get_state =/a #endif' \
    	-i dirmngr/server.c

	eautoreconf
	sed -i "/^VERSION='/ s/-unknown/'\"\$(ver_cut 3)\"'/" configure || die

	sed -i '/major=`echo \$gpg_error_config_version/ i\
    	gpg_error_config_version=`$GPG_ERROR_CONFIG --version`
	' configure

	sed -i 's|major=`echo \$gpg_error_config_version .*|major=$(echo "$gpg_error_config_version" | cut -d. -f1)|' configure
	sed -i 's|minor=`echo \$gpg_error_config_version .*|minor=$(echo "$gpg_error_config_version" | cut -d. -f2)|' configure
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

	cat > "${T}"/30gnupg <<- EOF || die
		CONFIG_PROTECT=/usr/share/gnupg/qualified.txt
	EOF
	doenvd "${T}"/30gnupg
}
