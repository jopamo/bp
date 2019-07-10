# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils git-r3 qmake-utils autotools systemd user

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"
EGIT_BRANCH="v$(ver_cut 1)_$(ver_cut 2)_x"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug server gui"

DEPEND=">=lib-dev/boost-1.62.0-r1:=
	lib-net/libtorrent
	dev-util/pkgconf
	gui-lib/qtcore:5
	gui-lib/qtnetwork:5[ssl]
	gui-lib/qtxml:5
	gui-lib/linguist-tools:5
	gui? (
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
		$(use_enable server webui)
		$(use_enable debug)
		$(use_enable gui)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
	eqmake5 ${S}/qbittorrent.pro
}

src_install() {
	emake INSTALL_ROOT="${ED}" install

	use server && systemd_dounit "${FILESDIR}"/qbittorrent.service
}

pkg_preinst() {
	use server && newusergroup qbtuser
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
