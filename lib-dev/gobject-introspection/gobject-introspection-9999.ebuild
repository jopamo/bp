# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1 meson flag-o-matic

DESCRIPTION="Introspection system for GObject-based libraries"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"

if [[ ${PV} = *9999 ]]; then
	#EGIT_BRANCH=gnome-$(ver_cut 1)
	EGIT_REPO_URI="https://github.com/GNOME/${PN}"
	inherit git-r3
else
	SNAPSHOT=f5c3a2e140ea14544271e680ee5437fe8d039f47
	SRC_URI="https://gitlab.gnome.org/GNOME/gobject-introspection/-/archive/${SNAPSHOT}/gobject-introspection-${SNAPSHOT}.tar.bz2 -> ${PN}-${SNAPSHOT}.tar.bz2"
	S=${WORKDIR}/gobject-introspection-${SNAPSHOT}
fi

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	lib-util/glib
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
