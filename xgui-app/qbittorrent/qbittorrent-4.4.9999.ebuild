# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg git-r3 qmake-utils autotools user flag-o-matic

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/qbittorrent/qBittorrent"
EGIT_BRANCH="v$(ver_cut 1)_$(ver_cut 2)_x"

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

src_prepare() {
	default
	sed '/^AM_INIT_AUTOMAKE/d' -i -- configure.ac || die
	sed '/^$QT_QMAKE/ s|^|echo |' -i -- configure.ac || die
	eautoreconf
}

src_configure() {
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	local myconf=(
		$(use_enable webui)
		$(use_enable debug)
		$(use_enable qt5 gui)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
	eqmake5 "${S}"/qbittorrent.pro
}

src_install() {
	emake INSTALL_ROOT="${ED}" install

	if use systemd; then
		insinto /usr/lib/systemd/system
		insopts -m 0644
		doins "${FILESDIR}/qbittorrent.service"
	fi
}
