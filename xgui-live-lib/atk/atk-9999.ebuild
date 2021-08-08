# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	dev-util/gtk-doc-am
	>=dev-util/pkgconf-0-r1
	>=sys-devel/gettext-0.19.2"

src_configure() {
        local emesonargs=(
                -Ddisable_introspection=$(usex introspection false)
        )
        meson_src_configure
}
