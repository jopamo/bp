# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/atk.git"

LICENSE="LGPL-2+"
SLOT="0"

KEYWORDS="amd64 arm64"

IUSE="+introspection"

RDEPEND="
	lib-live/glib
	introspection? ( lib-live/gobject-introspection )
"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	app-dev/gtk-doc-am
	>=app-dev/pkgconf-0-r1
	>=app-build/gettext-0.19.2"

src_configure() {
        local emesonargs=(
                $(meson_use introspection)
        )
        meson_src_configure
}
