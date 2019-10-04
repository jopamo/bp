# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils git-r3 qmake-utils autotools systemd user

DESCRIPTION="BitTorrent client in C++ and Qt"
HOMEPAGE="https://www.qbittorrent.org/"
EGIT_REPO_URI="https://github.com/${PN}/qBittorrent.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug server gui"

DEPEND="
	lib-dev/boost
	lib-net/libtorrent
	dev-util/pkgconf
	lib-gui/qtbase
	lib-gui/qttools
	gui? ( lib-gui/qtsvg )
"

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
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable server webui)
		$(use_enable debug)
		$(use_enable gui)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
	eqmake5 "${S}"/qbittorrent.pro
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
