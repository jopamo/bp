# Distributed under the terms of the GNU General Public License v2

EAPI=8


inherit python-single-r1 git-r3 autotools

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk-doc.git"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

DEPEND="
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	dev-python/six
	lib-core/libxslt
	lib-live/glib
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
