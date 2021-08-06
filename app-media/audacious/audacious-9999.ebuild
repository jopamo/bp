# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit xdg-utils autotools git-r3 flag-o-matic

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/audacious.git"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="nls"

PDEPEND="~app-media/audacious-plugins-${PV}"

RDEPEND="
	>=lib-dev/dbus-glib-0.60
	>=lib-dev/glib-2.28
	>=lib-gui/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	lib-gui/qtbase
"

DEPEND="${RDEPEND}
	dev-util/pkgconf
	nls? ( dev-util/intltool )"

append-flags -ffat-lto-objects

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-valgrind
		--enable-dbus
		--disable-gtk
		$(use_enable nls)
		--enable-qt
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

pkg_postinst() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}
