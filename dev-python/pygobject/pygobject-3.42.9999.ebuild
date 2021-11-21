# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-r1 flag-o-matic git-r3

DESCRIPTION="GLib's GObject library bindings for Python"
HOMEPAGE="https://wiki.gnome.org/Projects/PyGObject"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/pygobject"
EGIT_BRANCH="pygobject-$(ver_cut 1)-$(ver_cut 2)"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	dev-python/pycairo
	lib-live/glib
	lib-live/gobject-introspection
"

filter-flags -Wl,-z,defs
