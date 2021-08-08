# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson python-r1 flag-o-matic

DESCRIPTION="GLib's GObject library bindings for Python"
HOMEPAGE="https://wiki.gnome.org/Projects/PyGObject"
SRC_URI="https://ftp.acc.umu.se/pub/GNOME/sources/pygobject/$(ver_cut 1-2)/pygobject-${PV}.tar.xz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"

COMMON_DEPEND="${PYTHON_DEPS}
	>=lib-live/glib-2.38:2
	>=lib-live/gobject-introspection-1.46.0:=
"

RDEPEND="${COMMON_DEPEND}"

filter-flags -Wl,-z,defs

src_configure() {
        local emesonargs=(
        		-Dpycairo=false
        )
        meson_src_configure
}
