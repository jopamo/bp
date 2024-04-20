# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson flag-o-matic

DESCRIPTION="The GLib library of C routines"
HOMEPAGE="https://www.gtk.org/"

if [[ ${PV} = *9999 ]]; then
	EGIT_BRANCH=glib-$(ver_cut 1)-$(ver_cut 2)
	EGIT_REPO_URI="https://github.com/GNOME/${PN}"
	inherit git-r3
else
	SRC_URI="https://download.gnome.org/sources/glib/$(ver_cut 1-2)/${P}.tar.xz
			https://ftp.pieskovisko.sk/slackware/slackware-current/source/l/glib2/${P}.tar.xz"
fi

LICENSE="LGPL-2+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

DEPEND="
	app-core/attr[static-libs(+)]
	app-core/util-linux[mount,static-libs(+)]
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libffi[static-libs(+)]
	lib-core/libpcre2[static-libs(+)]
	lib-core/libxslt[static-libs(+)]
    app-core/util-linux[static-libs(+)]
    lib-core/libxml2[static-libs(+)]
    lib-core/zlib[static-libs(+)]
"

src_configure() {
	append-flags -Wno-error=format
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
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
