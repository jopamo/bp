# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools eutils multilib-minimal git-r3

DESCRIPTION="Scalable Vector Graphics (SVG) rendering library"
HOMEPAGE="https://wiki.gnome.org/Projects/LibRsvg"
EGIT_REPO_URI="https://github.com/GNOME/librsvg.git"
EGIT_BRANCH="librsvg-2.40"
LICENSE="LGPL-2"
SLOT="2"
KEYWORDS="amd64 arm64 x86"

IUSE="+introspection tools gtk"

RDEPEND="
	>=lib-dev/glib-2.34.3:2[${MULTILIB_USEDEP}]
	>=x11-libs/cairo-1.12.14-r4[${MULTILIB_USEDEP}]
	>=x11-libs/pango-1.36.3[${MULTILIB_USEDEP}]
	>=lib-dev/libxml2-2.9.1-r4:2[${MULTILIB_USEDEP}]
	>=lib-dev/libcroco-0.6.8-r1[${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.30.7:2[introspection?,${MULTILIB_USEDEP}]
	introspection? ( >=lib-dev/gobject-introspection-0.10.8:= )
	tools? ( >=x11-libs/gtk+-3.10.0:3 )
"
DEPEND="${RDEPEND}
	lib-dev/gobject-introspection-common
	dev-util/gtk-doc
	gtk? ( x11-libs/gtk+ )
	>=dev-util/pkgconfig-0-r1[${MULTILIB_USEDEP}]
"
src_prepare() {
	${S}/autogen.sh
	eautoreconf
	default
	multilib_copy_sources
}

multilib_src_configure() {
	local myconf=(
		--bindir="${EPREFIX}"/usr/bin
		--sbindir="${EPREFIX}"/usr/sbin
		--libdir="${EPREFIX}"/usr/$(get_libdir)
		--libexecdir="${EPREFIX}"/usr/libexec
		--sysconfdir="${EPREFIX}"/etc
		--localstatedir="${EPREFIX}"/var
		--disable-static
		--disable-tools
		$(multilib_native_use_enable introspection)
		--enable-pixbuf-loader
	)
	econf ${myconf[@]}
}

