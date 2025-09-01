# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info autotools doins

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md"
SNAPSHOT=2b9523a1efc1df39542311cc6f885f71be0bcf9a
SRC_URI="https://gitlab.com/cryptsetup/cryptsetup/-/archive/${SNAPSHOT}/cryptsetup-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/cryptsetup-${SNAPSHOT}"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="argon2 static static-libs udev urandom"

LIB_DEPEND="
	app-core/util-linux[static-libs(+)]
	app-fs/lvm2[static-libs(+)]
	lib-core/libgpg-error[static-libs(+)]
	lib-core/popt[static-libs(+)]
	lib-dev/json-c[static-libs(+)]
	virtual/ssl[static-libs(+)]
	argon2? ( app-crypto/argon2[static-libs(+)] )
	udev? ( app-core/systemd[static-libs(+)] )"

RDEPEND="static-libs? ( ${LIB_DEPEND} )
	${LIB_DEPEND//\[static-libs\(+\)\]}"
DEPEND="${RDEPEND}
	app-dev/pkgconf
	static? ( ${LIB_DEPEND} )"

pkg_setup() {
	local CONFIG_CHECK="~DM_CRYPT ~CRYPTO ~CRYPTO_CBC ~CRYPTO_SHA256"
	local WARNING_DM_CRYPT="CONFIG_DM_CRYPT:\tis not set (required for cryptsetup)\n"
	local WARNING_CRYPTO_SHA256="CONFIG_CRYPTO_SHA256:\tis not set (required for cryptsetup)\n"
	local WARNING_CRYPTO_CBC="CONFIG_CRYPTO_CBC:\tis not set (required for kernel 2.6.19)\n"
	local WARNING_CRYPTO="CONFIG_CRYPTO:\tis not set (required for cryptsetup)\n"
	check_extra_config
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-asciidoc
		--disable-internal-argon2
		--disable-nls
		--disable-rpath
		--enable-shared
		--with-crypto_backend="openssl"
		--with-tmpfilesdir="${EPREFIX}"/usr/lib/tmpfiles.d
	    --disable-ssh-token
		$(use_enable !urandom dev-random)
		$(use_enable argon2 libargon2)
		$(use_enable static static-cryptsetup)
		$(use_enable static-libs static)
		$(use_enable udev)
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
