# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1 meson flag-o-matic

DESCRIPTION="Introspection system for GObject-based libraries"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gobject-introspection.git"
	inherit git-r3
	EGIT_BRANCH=gnome-42
else
	SNAPSHOT=dd231b0faf587ff4e0e77519f724214e5876d5c2
	SRC_URI="https://gitlab.gnome.org/GNOME/gobject-introspection/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-live/glib
	lib-core/libffi
	${PYTHON_DEPS}
"
BDEPEND="
	app-build/bison
	app-build/flex
	app-dev/gtk-doc-am
	app-dev/pkgconf
"

filter-flags -Wl,-z,defs

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local emesonargs=(
		-Dpython="${EPYTHON}"
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	python_fix_shebang "${ED}"/usr/bin/
	python_optimize "${ED}"/usr/lib/gobject-introspection/giscanner
}
