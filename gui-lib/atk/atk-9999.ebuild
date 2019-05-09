# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3 meson

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://github.com/GNOME/atk.git"

LICENSE="LGPL-2+"
SLOT="0/1"

KEYWORDS="amd64 arm64"

IUSE="+introspection"

RDEPEND="
	lib-dev/glib
	introspection? ( lib-dev/gobject-introspection )
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
