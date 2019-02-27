# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit toolchain-funcs flag-o-matic autotools

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"

if [[ ${PV} == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/aircrack-ng/aircrack-ng.git"
	KEYWORDS="amd64 arm64"
else
	MY_PV=${PV/_/-}
	SRC_URI="http://download.${PN}.org/${PN}-${MY_PV}.tar.gz"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="+airdrop-ng +airgraph-ng kernel_linux kernel_FreeBSD +netlink +pcre +sqlite +experimental"

DEPEND="lib-net/libpcap
	lib-dev/openssl:0=
	netlink? ( lib-dev/libnl:3 )
	pcre? ( lib-dev/libpcre )
	experimental? ( lib-sys/zlib )
	sqlite? ( >=lib-sys/sqlite-3.4 )"
RDEPEND="${DEPEND}"
PDEPEND="kernel_linux? (
		app-net/iw
		sys-app/ethtool
		sys-app/usbutils
		sys-app/pciutils )
	sys-app/systemd"

pkg_setup() {
	MAKE_COMMON=(
		CC="$(tc-getCC)" \
		CXX="$(tc-getCXX)" \
		AR="$(tc-getAR)" \
		LD="$(tc-getLD)" \
		RANLIB="$(tc-getRANLIB)" \
		DESTDIR="${ED}"
	)
}

filter-flags -flto

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-asan
		$(use_enable netlink libnl)
		--with-experimental
		$(use_with sqlite sqlite3)
		--enable-shared
		--disable-static
		--without-opt
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_compile() {
	if [[ $($(tc-getCC) --version) == clang* ]] ; then
		#https://bugs.gentoo.org/show_bug.cgi?id=472890
		filter-flags -frecord-gcc-switches
	fi

	emake "${MAKE_COMMON[@]}"
}

src_test() {
	emake "${MAKE_COMMON[@]}" check
}

src_install() {
	einstalldocs
	emake "${MAKE_COMMON[@]}" install

	#we don't need aircrack-ng's oui updater, we have our own
	rm "${ED}"/usr/sbin/airodump-ng-oui-update
}
