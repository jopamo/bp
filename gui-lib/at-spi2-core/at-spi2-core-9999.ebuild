# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit multilib-minimal meson git-r3

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://github.com/GNOME/at-spi2-core.git"

LICENSE="LGPL-2+"
SLOT="2.27"
SONAME="${SLOT}"
KEYWORDS="amd64 arm64"

IUSE="docs introspection X"

RDEPEND="
	>=lib-dev/glib-2.36:2[${MULTILIB_USEDEP}]
	>=sys-app/dbus-1[${MULTILIB_USEDEP}]
	x11-libs/libSM[${MULTILIB_USEDEP}]
	x11-libs/libXi[${MULTILIB_USEDEP}]
	x11-libs/libXtst[${MULTILIB_USEDEP}]
	introspection? ( >=lib-dev/gobject-introspection-0.9.6:= )
	X? (
		x11-libs/libX11[${MULTILIB_USEDEP}]
		x11-libs/libXi[${MULTILIB_USEDEP}]
		x11-libs/libXtst[${MULTILIB_USEDEP}]
	)
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.40
	sys-devel/gettext
	dev-util/pkgconfig[${MULTILIB_USEDEP}]
"

src_prepare() {
	default
	multilib_copy_sources
}

multilib_src_configure() {
        local emesonargs=(
                -Denable_docs=$(usex docs true)
        )
        meson_src_configure
}
