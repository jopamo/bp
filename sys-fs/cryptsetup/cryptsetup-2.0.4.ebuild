# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{6,7,8} )

inherit autotools python-single-r1 linux-info libtool ltprune versionator multilib-minimal

DESCRIPTION="Tool to setup encrypted devices with dm-crypt"
HOMEPAGE="https://gitlab.com/cryptsetup/cryptsetup/blob/master/README.md"
SRC_URI="mirror://kernel/linux/utils/${PN}/v$(get_version_component_range 1-2)/${P/_/-}.tar.xz"

LICENSE="GPL-2+"
SLOT="0/12" # libcryptsetup.so version
[[ ${PV} != *_rc* ]] && \
KEYWORDS="amd64 arm64 x86"
CRYPTO_BACKENDS="+gcrypt kernel nettle openssl"

IUSE="${CRYPTO_BACKENDS} libressl nls pwquality python reencrypt static static-libs udev urandom"
REQUIRED_USE="^^ ( ${CRYPTO_BACKENDS//+/} )
	python? ( ${PYTHON_REQUIRED_USE} )
	static? ( !gcrypt )" #496612

LIB_DEPEND="
	lib-dev/json-c:=[static-libs(+)]
	lib-dev/libgpg-error[static-libs(+)]
	lib-dev/popt[static-libs(+)]
	>=sys-app/util-linux-2.31-r1[static-libs(+)]
	app-crypt/argon2:=[static-libs(+)]
	gcrypt? ( lib-dev/libgcrypt:0=[static-libs(+)] )
	nettle? ( >=lib-dev/nettle-2.4[static-libs(+)] )
	openssl? (
		!libressl? ( lib-dev/openssl:0=[static-libs(+)] )
		libressl? ( lib-dev/libressl:=[static-libs(+)] )
	)
	pwquality? ( lib-dev/libpwquality[static-libs(+)] )
	sys-fs/lvm2[static-libs(+)]
	udev? ( sys-app/systemd[static-libs(+)] )"
# We have to always depend on ${LIB_DEPEND} rather than put behind
# !static? () because we provide a shared library which links against
# these other packages. #414665
RDEPEND="static-libs? ( ${LIB_DEPEND} )
	${LIB_DEPEND//\[static-libs\(+\)\]}
	python? ( ${PYTHON_DEPS} )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
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

multilib_src_configure() {
	if use kernel ; then
		ewarn "Note that kernel backend is very slow for this type of operation"
		ewarn "and is provided mainly for embedded systems wanting to avoid"
		ewarn "userspace crypto libraries."
	fi

	use python && python_setup

	# We disable autotool python integration so we can use eclasses
	# for proper integration with multiple python versions.
	local myeconfargs=(
		--enable-system-argon2
		--enable-shared
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--with-tmpfilesdir="${EPREFIX%/}/usr/lib/tmpfiles.d"
		--with-crypto_backend=$(for x in ${CRYPTO_BACKENDS//+/} ; do usev ${x} ; done)
		$(use_enable nls)
		$(use_enable pwquality)
		$(use_enable python)
		$(use_enable reencrypt cryptsetup-reencrypt)
		$(use_enable static static-cryptsetup)
		$(use_enable static-libs static)
		$(use_enable udev)
		$(use_enable !urandom dev-random)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

multilib_src_test() {
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

multilib_src_install() {
	default

	if use static ; then
		mv "${ED%}"/usr/sbin/cryptsetup{.static,} || die
		mv "${ED%}"/usr/sbin/veritysetup{.static,} || die
		use reencrypt && { mv "${ED%}"/usr/sbin/cryptsetup-reencrypt{.static,} || die ; }
	fi
	prune_libtool_files --modules
}
