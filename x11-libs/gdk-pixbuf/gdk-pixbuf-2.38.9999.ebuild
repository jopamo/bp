# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 meson

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="https://git.gnome.org/browse/gdk-pixbuf"
EGIT_REPO_URI="https://github.com/GNOME/${PN}.git"
EGIT_BRANCH=gdk-pixbuf-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="+introspection +png +tiff +jpeg X"

COMMON_DEPEND="
	>=lib-dev/glib-2.48.0:2
	png? ( >=lib-media/libpng-1.4:0= )
	introspection? ( >=lib-dev/gobject-introspection-0.9.3:= )
	jpeg? ( lib-media/libjpeg-turbo )
	tiff? ( >=lib-media/tiff-3.9.2:0= )
	X? ( x11-libs/libX11 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19
	dev-util/pkgconf
	x11-misc/shared-mime-info"

RDEPEND="${COMMON_DEPEND}"

src_configure() {
	local emesonargs=(
		$(meson_use png)
		$(meson_use tiff)
		$(meson_use jpeg)
		$(meson_use X x11)
		$(meson_use introspection gir)
		-Ddocs=false
		)
		meson_src_configure
}

pkg_preinst() {
	# Make sure loaders.cache belongs to gdk-pixbuf alone
	local cache="usr/lib/${PN}-2.0/2.10.0/loaders.cache"

	if [[ -e ${EROOT}/${cache} ]]; then
		cp "${EROOT}"/${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postinst() {
	unset __GL_NO_DSO_FINALIZER
	gdk-pixbuf-query-loaders > "${EROOT}"/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache
}
