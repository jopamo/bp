# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit flag-o-matic

DESCRIPTION="A lightweight secured SOCKS5 proxy for embedded devices and low end boxes"
HOMEPAGE="https://github.com/shadowsocks/shadowsocks-rust"
SNAPSHOT=5dd75b1373f7d9cd84756369a916110f93239a7b
SRC_URI="https://github.com/shadowsocks/shadowsocks-rust/archive/${SNAPSHOT}.tar.gz -> shadowsocks-rust-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/shadowsocks-rust-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs systemd"

DEPEND="virtual/rust"

src_prepare() {
	default
	filter-flags -flto*
}

src_install() {
	emake PREFIX="${ED}"/usr/bin install

	dodir "/etc/shadowsocks"
	insinto "/etc/shadowsocks"
	doins "${FILESDIR}/ss.json"

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		newins "${FILESDIR}/shadowsocks_at.service" "shadowsocks-local@.service"
		newins "${FILESDIR}/shadowsocks-server_at.service" "shadowsocks-server@.service"
		newins "${FILESDIR}/shadowsocks-redir_at.service" "shadowsocks-redir@.service"
		newins "${FILESDIR}/shadowsocks-tunnel_at.service" "shadowsocks-tunnel@.service"
	fi
}
