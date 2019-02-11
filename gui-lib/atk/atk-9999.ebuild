# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit git-r3 multilib-minimal meson

DESCRIPTION="GTK+ & GNOME Accessibility Toolkit"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://github.com/GNOME/atk.git"

LICENSE="LGPL-2+"
SLOT="2.27"
SONAME="${SLOT}"
KEYWORDS="amd64 arm64"

IUSE="+introspection"

RDEPEND="
	lib-dev/glib
	introspection? ( >=lib-dev/gobject-introspection-0.6.7:= )
"
DEPEND="${RDEPEND}
	>=dev-lang/perl-5
	dev-util/gtk-doc-am
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]
	>=sys-devel/gettext-0.19.2
"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
        local emesonargs=(
                -Ddisable_introspection=$(usex introspection false)
        )
        meson_src_configure
}
