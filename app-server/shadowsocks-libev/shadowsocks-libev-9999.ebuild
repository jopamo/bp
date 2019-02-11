# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools systemd git-r3

DESCRIPTION="A lightweight secured SOCKS5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"
EGIT_REPO_URI="https://github.com/shadowsocks/shadowsocks-libev.git"
LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"
IUSE="debug"

RDEPEND="lib-net/mbedtls
	>=lib-dev/libsodium-1.0.8
	lib-dev/libev
	lib-dev/libpcre
	"
DEPEND="${RDEPEND}
	sys-kernel/stable-sources
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
	find "${D}" -name '*.la' -delete || die

	dodir "/etc/shadowsocks"
	insinto "/etc/shadowsocks"
	doins "${FILESDIR}/ss.json"

	systemd_newunit "${FILESDIR}/${PN}_at.service" "${PN}-local@.service"
	systemd_newunit "${FILESDIR}/${PN}-server_at.service" "${PN}-server@.service"
	systemd_newunit "${FILESDIR}/${PN}-redir_at.service" "${PN}-redir@.service"
	systemd_newunit "${FILESDIR}/${PN}-tunnel_at.service" "${PN}-tunnel@.service"
}
