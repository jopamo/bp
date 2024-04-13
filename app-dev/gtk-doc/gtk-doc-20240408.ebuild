# Distributed under the terms of the GNU General Public License v2

EAPI=8


inherit python-single-r1 autotools

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="https://www.gtk.org/gtk-doc/"

SNAPSHOT=399a58aac0ddc50d33eb56c2ad4ed12745311a0b
SRC_URI="https://gitlab.gnome.org/GNOME/gtk-doc/-/archive/${SNAPSHOT}/gtk-doc-${SNAPSHOT}.tar.bz2 -> gtk-doc-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/gtk-doc-${SNAPSHOT}"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

DEPEND="
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	dev-python/six
	lib-core/libxslt
	lib-util/glib
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm "${ED}"/usr/share/aclocal/gtk-doc.m4 || die
}
