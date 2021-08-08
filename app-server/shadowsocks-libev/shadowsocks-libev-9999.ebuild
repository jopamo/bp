# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="A lightweight secured SOCKS5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-libev"
EGIT_REPO_URI="https://github.com/shadowsocks/shadowsocks-libev.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs systemd"

RDEPEND="lib-net/mbedtls
	>=lib-live/libsodium-1.0.8
	lib-dev/libev
	lib-dev/libpcre
	"
DEPEND="${RDEPEND}
	sys-kernel/linux-headers
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

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		newins "${FILESDIR}/${PN}_at.service" "${PN}-local@.service"
		newins "${FILESDIR}/${PN}-server_at.service" "${PN}-server@.service"
		newins "${FILESDIR}/${PN}-redir_at.service" "${PN}-redir@.service"
		newins "${FILESDIR}/${PN}-tunnel_at.service" "${PN}-tunnel@.service"
	fi

	use static-libs || find "${ED}" -name '*.a' -delete
}
