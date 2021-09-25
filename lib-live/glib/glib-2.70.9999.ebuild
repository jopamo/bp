# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit python-r1 git-r3 meson

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
EGIT_BRANCH=glib-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs dtrace"

RDEPEND="
	lib-core/libpcre
	app-core/util-linux[mount]
	app-core/attr
"
DEPEND="
	lib-core/libxslt
	app-text/docbook-xml-dtd
	app-text/docbook-xsl-stylesheets
"

src_configure() {
        local emesonargs=(
				-Ddefault_library=$(usex static-libs static shared)
				$(meson_use dtrace)
				-Dgtk_doc=false
				-Dselinux=disabled
				-Dlibmount=enabled
				-Dxattr=true
        )
        meson_src_configure
}

pkg_postinst() {
	glib-compile-schemas "${EROOT}"/usr/share/glib-2.0/schemas/
}
