# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs flag-o-matic autotools

DESCRIPTION="WLAN tools for breaking 802.11 WEP/WPA keys"
HOMEPAGE="http://www.aircrack-ng.org"

SNAPSHOT=8177f63da776cf48e097c7205d4c943736625dc4
SRC_URI="https://github.com/aircrack-ng/aircrack-ng/archive/${SNAPSHOT}.tar.gz -> aircrack-ng-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="+airdrop-ng +airgraph-ng +netlink +pcre +sqlite +experimental"

DEPEND="
	lib-net/libpcap
	virtual/ssl
	netlink? ( lib-net/libnl )
	pcre? ( lib-core/libpcre )
	experimental? ( lib-core/zlib )
	sqlite? ( lib-core/sqlite )
"
PDEPEND="
		app-net/iw
		app-net/ethtool
		app-var/usbutils
		app-core/pciutils
"

filter-flags -flto\=\*
append-flags -fcommon

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

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
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
	emake "${MAKE_COMMON[@]}"
}

src_test() {
	emake "${MAKE_COMMON[@]}" check
}

src_install() {
	emake "${MAKE_COMMON[@]}" install
	rm "${ED}"/usr/sbin/airodump-ng-oui-update
}
