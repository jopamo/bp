# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson python-single-r1

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
SNAPSHOT=48b3c0bde4a3028b2153ddc220ca37a1ca584b67
SRC_URI="https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/${SNAPSHOT}/gtk-doc-${SNAPSHOT}.tar.bz2 -> gtk-doc-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/gtk-doc-${SNAPSHOT}"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="
	${PYTHON_DEPS}
	app-dev/pkgconf
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	dev-python/pygments
	lib-core/libxslt
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	local emesonargs=(
		-Dtests=false
		-Dyelp_manual=false
	)
	meson_src_configure
}

src_install() {
	meson_src_install
	rm "${ED}"/usr/share/aclocal/gtk-doc.m4 || die
}
