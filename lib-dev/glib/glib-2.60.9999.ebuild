# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit python-r1 git-r3 meson

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://github.com/GNOME/${PN}.git"
EGIT_BRANCH=glib-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="2"
SONAME="2"
IUSE="debug static-libs xattr libmount internal_pcre dtrace"

KEYWORDS="amd64 arm64"

RDEPEND="
	>=lib-dev/libpcre-8.13:3
	kernel_linux? ( sys-app/util-linux )
	>=sys-app/attr-2.4.47-r1
"
DEPEND="
	lib-dev/libxslt
	>=app-text/docbook-xml-dtd-4.5
	>=app-text/docbook-xsl-stylesheets-1.79.1
"

src_configure() {
        local emesonargs=(
        		-Ddefault_library=$(usex static-libs static shared)
        		$(meson_use xattr)
                $(meson_use xattr)
                $(meson_use libmount)
                $(meson_use internal_pcre)
                $(meson_use dtrace)
                -Dgtk_doc=false
                -Dselinux=disabled
        )
        meson_src_configure
}

pkg_postinst() {
	glib-compile-schemas "${EROOT}"usr/share/glib-2.0/schemas/
}
