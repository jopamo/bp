# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils xdg-utils autotools git-r3 multilib-minimal

DESCRIPTION="Audacious Player - Your music, your way, no exceptions"
HOMEPAGE="https://audacious-media-player.org/"
EGIT_REPO_URI="https://github.com/audacious-media-player/audacious.git"

LICENSE="BSD-2"
SLOT="0"
IUSE="nls"
KEYWORDS="amd64 arm64 x86"

PDEPEND="~app-media/audacious-plugins-${PV}"

RDEPEND="
	>=lib-dev/dbus-glib-0.60
	>=lib-dev/glib-2.28
	>=x11-libs/cairo-1.2.6
	>=x11-libs/pango-1.8.0
	gui-lib/qtcore:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( dev-util/intltool )"

src_prepare() {
	eautoreconf
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
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
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_desktop_database_update
	gnome2_icon_cache_update
}
