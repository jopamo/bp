# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-r1 flag-o-matic git-r3

DESCRIPTION="GLib's GObject library bindings for Python"
HOMEPAGE="https://wiki.gnome.org/Projects/PyGObject"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/pygobject"

LICENSE="LGPL-2.1+"
SLOT="0"
#KEYWORDS="amd64 arm64"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"

DEPEND="
	${PYTHON_DEPS}
	lib-live/glib
	lib-live/gobject-introspection
"

filter-flags -Wl,-z,defs

src_configure() {
        local emesonargs=(
			-Dpycairo=false
        )
        meson_src_configure
}
