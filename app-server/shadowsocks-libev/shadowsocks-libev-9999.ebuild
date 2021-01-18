# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools systemd git-r3

DESCRIPTION="A lightweight secured SOCKS5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"
EGIT_REPO_URI="https://github.com/shadowsocks/shadowsocks-libev.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs systemd"

RDEPEND="lib-net/mbedtls
	>=lib-dev/libsodium-1.0.8
	lib-dev/libev
	lib-dev/libpcre
	"
DEPEND="${RDEPEND}
	virtual/kernel-headers
	lib-net/c-ares"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		--disable-documentation
		$(use_enable debug assert)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default

	dodir "/etc/shadowsocks"
	insinto "/etc/shadowsocks"
	doins "${FILESDIR}/ss.json"

	use systemd && systemd_newunit "${FILESDIR}/${PN}_at.service" "${PN}-local@.service"
	use systemd && systemd_newunit "${FILESDIR}/${PN}-server_at.service" "${PN}-server@.service"
	use systemd && systemd_newunit "${FILESDIR}/${PN}-redir_at.service" "${PN}-redir@.service"
	use systemd && systemd_newunit "${FILESDIR}/${PN}-tunnel_at.service" "${PN}-tunnel@.service"

	use static-libs || find "${ED}" -name '*.a' -delete
}
