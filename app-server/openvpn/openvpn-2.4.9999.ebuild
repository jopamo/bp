# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools flag-o-matic user systemd linux-info git-r3

DESCRIPTION="Robust and highly flexible tunneling application compatible with many OSes"
EGIT_REPO_URI="https://github.com/OpenVPN/${PN}.git"
EGIT_BRANCH="release/2.4"
EGIT_SUBMODULES=(-cmocka)
HOMEPAGE="http://openvpn.net/"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"

IUSE="down-root examples inotify +iproute2 libressl lz4 +lzo mbedtls pam"
IUSE+=" pkcs11 +plugins selinux +ssl static systemd test"

REQUIRED_USE="static? ( !plugins !pkcs11 )
	lzo? ( !lz4 )
	pkcs11? ( ssl )
	mbedtls? ( ssl !libressl )
	pkcs11? ( ssl )
	!plugins? ( !pam !down-root )
	inotify? ( plugins )"

CDEPEND="
	kernel_linux? (
		iproute2? ( sys-app/iproute2[-minimal] )
		!iproute2? ( sys-app/net-tools )
	)
	pam? ( lib-sys/pam )
	ssl? (
		!mbedtls? (
			!libressl? ( >=lib-dev/openssl-0.9.8:* )
			libressl? ( lib-dev/libressl )
		)
		mbedtls? ( lib-net/mbedtls )
	)
	lz4? ( app-compression/lz4 )
	lzo? ( >=lib-dev/lzo-1.07 )
	pkcs11? ( >=lib-dev/pkcs11-helper-1.11 )"

CONFIG_CHECK="~TUN"

pkg_setup()  {
	linux-info_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	use static && append-ldflags -Xcompiler -static
	SYSTEMD_UNIT_DIR=$(systemd_get_systemunitdir) \
	TMPFILES_DIR="/usr/lib/tmpfiles.d" \
	econf \
		$(usex mbedtls 'with-crypto-library' 'mbedtls' '' '') \
		$(use_enable inotify async-push) \
		$(use_enable lz4) \
		$(use_enable lzo) \
		$(use_enable pkcs11) \
		$(use_enable plugins) \
		$(use_enable iproute2) \
		$(use_enable pam plugin-auth-pam) \
		$(use_enable down-root plugin-down-root) \
		$(use_enable systemd)
}

src_test() {
	make check || die "top-level tests failed"
	pushd tests/unit_tests > /dev/null || die
	make check || die "unit tests failed"
	popd > /dev/null || die
}

src_install() {
	default
	find "${ED}/usr" -name '*.la' -delete

	# install examples, controlled by the respective useflag
	if use examples ; then
		# dodoc does not supportly support directory traversal, #15193
		insinto /usr/share/doc/${PF}/examples
		doins -r sample contrib
	fi
}
