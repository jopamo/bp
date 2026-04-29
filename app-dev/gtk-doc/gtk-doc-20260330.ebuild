# Distributed under the terms of the GNU General Public License v2

inherit meson python-single-r1

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
SNAPSHOT=f3424c6ac21bad7e7f81d941860d134c978cf31d
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
	dev-pypi/pygments
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
	python_fix_shebang "${ED}/usr/bin"
}
