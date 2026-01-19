# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="https://git.gnome.org/browse/gdk-pixbuf"
SNAPSHOT=5406817f56fcb270b2f9246d29c4049bc623caf5
SRC_URI="https://github.com/jopamo/gdk-pixbuf/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="introspection"

DEPEND="
	lib-core/glib
	xmedia-lib/libjpeg-turbo
	xmedia-lib/libpng
	xmedia-lib/tiff
	introspection? ( lib-dev/gobject-introspection )
"
BDEPEND="
	app-build/gettext
	app-core/debianutils
	app-dev/gtk-doc-am
	app-dev/pkgconf
	dev-py/docutils
	xgui-desktop/shared-mime-info
"

src_configure() {
	local emesonargs=(
		-Dothers=enabled
		-Dbuiltin_loaders=all
		$(meson_feature introspection)
		-Ddocs=false
		-Dtests=false
	)
	meson_src_configure
}

pkg_preinst() {
	# Make sure loaders.cache belongs to gdk-pixbuf alone
	mkdir -p "${ED}"/usr/lib/gdk-pixbuf-2.0/2.10.0/

	local cache="usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache"

	if [[ -e ${EROOT}/${cache} ]]; then
		cp "${EROOT}"/${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postinst() {
	einfo "Updating gdk-pixbuf loader cache"
	gdk-pixbuf-query-loaders --update-cache
}
