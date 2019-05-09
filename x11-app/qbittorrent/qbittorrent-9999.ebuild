# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit xdg-utils git-r3 qmake-utils autotools

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"

KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug webui gui"

DEPEND=">=lib-dev/boost-1.62.0-r1:=
	lib-net/libtorrent
	dev-util/pkgconf
	gui-lib/qtcore:5
	gui-lib/qtnetwork:5[ssl]
	gui-lib/qtxml:5
	gui-lib/linguist-tools:5
	gui? (
			gui-lib/qtsingleapplication
			gui-lib/qtdbus:5
			gui-lib/qtgui:5
			gui-lib/qtsvg:5
			gui-lib/qtwidgets:5
		)"

src_prepare() {
	default
	sed '/^AM_INIT_AUTOMAKE/d' -i -- configure.ac || die
	sed '/^$QT_QMAKE/ s|^|echo |' -i -- configure.ac || die
	eautoreconf
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib64
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable webui)
		$(use_enable debug)
		$(use_enable gui)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
	eqmake5 ${S}/qbittorrent.pro
}

src_install() {
	emake INSTALL_ROOT="${D}" install
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
