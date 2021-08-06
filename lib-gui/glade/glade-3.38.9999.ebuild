# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Glade is a RAD tool to enable quick & easy development of user interfaces for the GTK+ toolkit and the GNOME desktop environment."
HOMEPAGE="https://gitlab.gnome.org/GNOME/glade"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/glade.git"
EGIT_BRANCH="glade-$(ver_cut 1)-$(ver_cut 2)"

LICENSE="LGPL-2+"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="introspection"

DEPEND="
	x11-live-libs/gtk+:3
	lib-core/libxml2
"

src_configure() {
        local emesonargs=(
                $(meson_use introspection)
        )
        meson_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
