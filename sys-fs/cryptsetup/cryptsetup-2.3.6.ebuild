# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools python-single-r1 linux-info

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md"
SRC_URI="mirror://kernel/linux/utils/${PN}/v$(ver_cut 1-2)/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls python reencrypt static static-libs tmpfilesd udev urandom"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

LIB_DEPEND="
	lib-dev/json-c:=[static-libs(+)]
	lib-dev/libgpg-error[static-libs(+)]
	lib-dev/popt[static-libs(+)]
	>=sys-app/util-linux-2.31-r1[static-libs(+)]
	app-crypt/argon2:=[static-libs(+)]
	lib-dev/libgcrypt:0=[static-libs(+)]
	sys-fs/lvm2[static-libs(+)]
	udev? ( sys-app/systemd[static-libs(+)] )"

RDEPEND="static-libs? ( ${LIB_DEPEND} )
	${LIB_DEPEND//\[static-libs\(+\)\]}
	python? ( ${PYTHON_DEPS} )"
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

src_prepare() {
	sed -i '/^LOOPDEV=/s:$: || exit 0:' tests/{compat,mode}-test || die
	default
	eautoreconf
}

src_configure() {
	use python && python_setup

	local myconf=(
		--enable-system-argon2
		--enable-shared
		--with-tmpfilesdir=$(usex tmpfilesd "${EPREFIX}"/usr/lib/tmpfiles.d "false")
		--with-crypto_backend="gcrypt"
		$(use_enable nls)
		$(use_enable python)
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
	use static-libs || find "${ED}" -name "*.la" -delete || die
}
