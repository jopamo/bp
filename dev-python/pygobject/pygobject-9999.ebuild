# Distributed under the terms of the GNU General Public License v2

EAPI=6


inherit meson git-r3 python-r1 flag-o-matic

DESCRIPTION="GLib's GObject library bindings for Python"
HOMEPAGE="https://wiki.gnome.org/Projects/PyGObject"
EGIT_REPO_URI="https://github.com/GNOME/pygobject.git"

LICENSE="LGPL-2.1+"
SLOT="3"
KEYWORDS="amd64 arm64"

REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
"

COMMON_DEPEND="${PYTHON_DEPS}
	>=lib-dev/glib-2.38:2
	>=lib-dev/gobject-introspection-1.46.0:=
"

RDEPEND="${COMMON_DEPEND}"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

src_configure() {
        local emesonargs=(
        		-Dpycairo=false
        )
        meson_src_configure
}
