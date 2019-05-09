# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit meson git-r3

DESCRIPTION="D-Bus accessibility specifications and registration daemon"
HOMEPAGE="https://wiki.gnome.org/Accessibility"
EGIT_REPO_URI="https://github.com/GNOME/at-spi2-core.git"

LICENSE="LGPL-2+"
SLOT="2.27"
SONAME="${SLOT}"
KEYWORDS="amd64 arm64"

IUSE="docs introspection X"

RDEPEND="
	>=lib-dev/glib-2.36:2
	>=sys-app/dbus-1
	x11-libs/libSM
	x11-libs/libXi
	x11-libs/libXtst
	introspection? ( >=lib-dev/gobject-introspection-0.9.6:= )
	X? (
		x11-libs/libX11
		x11-libs/libXi
		x11-libs/libXtst
	)
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.9
	>=dev-util/intltool-0.40
	sys-devel/gettext
	dev-util/pkgconf
"
