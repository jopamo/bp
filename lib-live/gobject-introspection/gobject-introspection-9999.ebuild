# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-single-r1 meson flag-o-matic

DESCRIPTION="Introspection system for GObject-based libraries"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gobject-introspection.git"
	inherit git-r3
	#EGIT_BRANCH=
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=dd231b0faf587ff4e0e77519f724214e5876d5c2
	SRC_URI="https://gitlab.gnome.org/GNOME/gobject-introspection/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"

RDEPEND="
	>=lib-live/gobject-introspection-common-${PV}
	lib-live/glib
	lib-core/libffi
	app-dev/pkgconf
	${PYTHON_DEPS}
"
DEPEND="
	>=app-dev/gtk-doc-am-1.19
	app-build/bison
	app-build/flex
"

filter-flags -Wl,-z,defs

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	meson_src_install

	# Prevent collision with gobject-introspection-common
	rm -v "${ED}"/usr/share/aclocal/introspection.m4 \
		"${ED}"/usr/share/gobject-introspection-1.0/Makefile.introspection || die
	rmdir "${ED}"/usr/share/aclocal || die
}
