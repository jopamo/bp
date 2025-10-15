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

IUSE="introspection static-libs"

DEPEND="
	app-core/attr
	app-core/util-linux[mount]
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libffi
	lib-core/libpcre2
	lib-core/libxslt
    app-core/util-linux
    lib-core/libxml2
    lib-core/zlib
"

src_configure() {
	filter-flags -Wl,-z,defs

	append-flags -Wno-error=format
	local emesonargs=(
		-Ddefault_library=$(usex static-libs both shared)
		-Ddtrace=disabled
		-Ddocumentation=false
		-Dlibmount=disabled
		-Dselinux=disabled
		-Dxattr=true
		-Dtests=false
		-Dnls=disabled
		$(meson_feature introspection)
	)
	meson_src_configure
}

pkg_postinst() {
	mkdir -p "${EROOT}"/usr/share/glib-2.0/gettext/
	glib-compile-schemas "${EROOT}"/usr/share/glib-2.0/schemas/
}
