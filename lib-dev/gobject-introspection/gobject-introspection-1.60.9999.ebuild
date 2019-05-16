# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit python-single-r1 meson flag-o-matic

DESCRIPTION="Introspection system for GObject-based libraries"
HOMEPAGE="https://wiki.gnome.org/Projects/GObjectIntrospection"
EGIT_REPO_URI="https://github.com/GNOME/gobject-introspection.git"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://github.com/GNOME/gobject-introspection.git"
	inherit git-r3
	EGIT_BRANCH=gnome-3-32
	KEYWORDS="amd64 arm64"
else
	SNAPSHOT=dd231b0faf587ff4e0e77519f724214e5876d5c2
	SRC_URI="https://github.com/GNOME/gobject-introspection/archive/${SNAPSHOT}.zip -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"

RDEPEND="
	>=lib-dev/gobject-introspection-common-${PV}
	lib-dev/glib
	lib-dev/libffi
	dev-util/pkgconf
	${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.19
	sys-devel/bison
	sys-devel/flex
"

filter-flags -flto -Wl,-z,defs -Wl,-z,relro

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
