# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 meson

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
EGIT_BRANCH=glib-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

RDEPEND="
	app-core/attr
	app-core/util-linux[mount]
	lib-core/libpcre
"
DEPEND="
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libxslt
"

src_configure() {
        local emesonargs=(
				-Ddefault_library=$(usex static-libs static shared)
				-Ddtrace=false
				-Dgtk_doc=false
				-Dlibmount=enabled
				-Dselinux=disabled
				-Dxattr=true
        )
        meson_src_configure
}

pkg_postinst() {
	glib-compile-schemas "${EROOT}"/usr/share/glib-2.0/schemas/
}
