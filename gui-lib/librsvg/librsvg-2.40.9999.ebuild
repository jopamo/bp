# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"
EGIT_REPO_URI="https://github.com/GNOME/librsvg.git"
EGIT_BRANCH="librsvg-$(ver_cut 1).$(ver_cut 2)"
LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="+introspection tools gtk"

RDEPEND="
	>=lib-dev/glib-2.34.3:2
	>=x11-libs/cairo-1.12.14-r4
	>=x11-libs/pango-1.36.3
	>=lib-dev/libxml2-2.9.1-r4:2
	>=lib-dev/libcroco-0.6.8-r1
	>=x11-libs/gdk-pixbuf-2.30.7:2[introspection]
	introspection? ( >=lib-dev/gobject-introspection-0.10.8:= )
	tools? ( >=x11-libs/gtk+-3.10.0:3 )
"
DEPEND="${RDEPEND}
	lib-dev/gobject-introspection-common
	dev-util/gtk-doc
	gtk? ( x11-libs/gtk+ )
	>=dev-util/pkgconf-0-r1
"
src_prepare() {
	${S}/autogen.sh
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
		--disable-static
		--disable-tools
		$(use_enable introspection)
		--enable-pixbuf-loader
	)
	econf ${myconf[@]}
}

