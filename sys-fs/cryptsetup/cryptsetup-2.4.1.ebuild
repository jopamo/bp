# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md"
SRC_URI="mirror://kernel/linux/utils/${PN}/v$(ver_cut 1-2)/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+argon2 reencrypt static static-libs tmpfilesd udev urandom"

LIB_DEPEND="
	lib-live/json-c[static-libs(+)]
	lib-core/libgpg-error[static-libs(+)]
	lib-core/popt[static-libs(+)]
	app-core/util-linux[static-libs(+)]
	lib-core/libgcrypt[static-libs(+)]
	sys-fs/lvm2[static-libs(+)]
	argon2? ( app-crypt/argon2[static-libs(+)] )
	udev? ( app-core/systemd[static-libs(+)] )"

RDEPEND="static-libs? ( ${LIB_DEPEND} )
	${LIB_DEPEND//\[static-libs\(+\)\]}"
DEPEND="${RDEPEND}
	dev-util/pkgconf
	static? ( ${LIB_DEPEND} )"

S="${WORKDIR}/${P/_/-}"

pkg_setup() {
	local CONFIG_CHECK="~DM_CRYPT ~CRYPTO ~CRYPTO_CBC ~CRYPTO_SHA256"
	local WARNING_DM_CRYPT="CONFIG_DM_CRYPT:\tis not set (required for cryptsetup)\n"
	local WARNING_CRYPTO_SHA256="CONFIG_CRYPTO_SHA256:\tis not set (required for cryptsetup)\n"
	local WARNING_CRYPTO_CBC="CONFIG_CRYPTO_CBC:\tis not set (required for kernel 2.6.19)\n"
	local WARNING_CRYPTO="CONFIG_CRYPTO:\tis not set (required for cryptsetup)\n"
	check_extra_config
}

src_configure() {
	local myconf=(
	    --disable-ssh-token
		--disable-internal-argon2
		--enable-shared
		--with-tmpfilesdir=$(usex tmpfilesd "${EPREFIX}"/usr/lib/tmpfiles.d "")
		--with-crypto_backend="gcrypt"
		--disable-nls
		$(use_enable argon2 libargon2)
		$(use_enable reencrypt cryptsetup-reencrypt)
		$(use_enable static static-cryptsetup)
		$(use_enable static-libs static)
		$(use_enable udev)
		$(use_enable !urandom dev-random)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_test() {
	if [[ ! -e /dev/mapper/control ]] ; then
		ewarn "No /dev/mapper/control found -- skipping tests"
		return 0
	fi

	local p
	for p in /dev/mapper /dev/loop* ; do
		addwrite ${p}
	done

	default
}

src_install() {
	default

	if use static ; then
		mv "${ED%}"/usr/sbin/cryptsetup{.static,} || die
		mv "${ED%}"/usr/sbin/veritysetup{.static,} || die
		use reencrypt && { mv "${ED%}"/usr/sbin/cryptsetup-reencrypt{.static,} || die ; }
	fi
}
