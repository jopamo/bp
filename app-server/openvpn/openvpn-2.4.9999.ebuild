# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic user systemd linux-info git-r3

DESCRIPTION="Robust and highly flexible tunneling application compatible with many OSes"
HOMEPAGE="http://openvpn.net/"
EGIT_REPO_URI="https://github.com/OpenVPN/${PN}.git"
EGIT_BRANCH="release/$(ver_cut 1).$(ver_cut 2)"
EGIT_SUBMODULES=(-cmocka)

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="down-root examples inotify +iproute2 lz4 mbedtls pam pkcs11 +plugins static systemd test"

REQUIRED_USE="static? ( !plugins !pkcs11 )
	!plugins? ( !pam !down-root )
	inotify? ( plugins )"

CDEPEND="
	iproute2? ( app-net/iproute2[-minimal] )
	!iproute2? ( sys-app/net-tools )
	pam? ( lib-sys/pam )
	lib-net/mbedtls
	)
	lz4? ( app-compression/lz4 )
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
		--with-crypto-library=mbedtls \
		$(use_enable inotify async-push) \
		$(use_enable lz4) \
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
