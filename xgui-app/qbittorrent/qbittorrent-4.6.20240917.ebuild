# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake user flag-o-matic

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"

SNAPSHOT=a869e4151c4b330f8a64456d7d66127f09dc57c1
SRC_URI="https://github.com/qbittorrent/qBittorrent/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/qBittorrent-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="createuser debug systemd qt5 webui"

DEPEND="
	lib-dev/boost
	lib-misc/libtorrent
	xgui-lib/qtbase
	xgui-lib/qttools
	qt5? ( xgui-lib/qtsvg )
"

pkg_setup() {
	use createuser && enewuser qbittorrent /usr/sbin/nologin "/var/lib/qbittorrent" qbittorrent
}

src_configure() {
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	cmake_src_configure
}

src_install() {
	cmake_src_install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/qbittorrent.service"
	fi
}
