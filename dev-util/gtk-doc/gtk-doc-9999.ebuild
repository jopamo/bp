# Distributed under the terms of the GNU General Public License v2

EAPI=7


inherit python-single-r1 git-r3 autotools

DESCRIPTION="GTK+ Documentation Generator"
HOMEPAGE="https://www.gtk.org/gtk-doc/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk-doc.git"

LICENSE="GPL-2 FDL-1.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug"

DEPEND="lib-dev/libxslt
	app-text/docbook-xml-dtd
	>=app-text/docbook-xsl-stylesheets-1.79.1
	dev-python/six
	dev-util/itstool
	dev-util/pkgconf
	lib-dev/glib
"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/lib
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		$(use_enable debug)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}

src_install() {
	default
	rm "${ED}"/usr/share/aclocal/gtk-doc.m4 || die
}
