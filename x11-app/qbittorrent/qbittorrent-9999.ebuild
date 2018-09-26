# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils git-r3 qmake-utils autotools

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"

KEYWORDS="amd64 arm64 x86"

LICENSE="GPL-2"
SLOT="0"
IUSE="static-libs debug webui +gui"

RDEPEND="
	>=lib-dev/boost-1.62.0-r1:=
	gui-lib/qtcore:5
	gui-lib/qtnetwork:5[ssl]
	gui-lib/qtsingleapplication
	gui-lib/qtxml:5
	lib-net/libtorrent
	lib-sys/zlib
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtsvg:5
	gui-lib/qtwidgets:5"

DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5
	dev-util/pkgconfig"

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
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
