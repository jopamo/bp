# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils git-r3 qmake-utils autotools user

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="createuser debug systemd qt5 webui"

DEPEND="
	lib-dev/boost
	lib-net/libtorrent
	dev-util/pkgconf
	lib-gui/qtbase
	lib-gui/qttools
	qt5? ( lib-gui/qtsvg )
"

pkg_setup() {
	use createuser && enewuser ${PN} /usr/sbin/nologin "/var/lib/${PN}" ${PN}
}

src_prepare() {
	default
	sed '/^AM_INIT_AUTOMAKE/d' -i -- configure.ac || die
	sed '/^$QT_QMAKE/ s|^|echo |' -i -- configure.ac || die
	eautoreconf
}

src_configure() {
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
		doins "${FILESDIR}/${PN}.service"
	fi
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
