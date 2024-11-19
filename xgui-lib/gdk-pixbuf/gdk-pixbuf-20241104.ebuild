# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="https://git.gnome.org/browse/gdk-pixbuf"

SNAPSHOT=9bc76817ee2034965e6cf6ed13eeca3c02706ade
SRC_URI="https://gitlab.gnome.org/GNOME/gdk-pixbuf/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
S=${WORKDIR}/${PN}-${SNAPSHOT}

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64 arm64"

DEPEND="
	lib-util/glib
	lib-dev/gobject-introspection
	xmedia-lib/libjpeg-turbo
	xmedia-lib/libpng
	xmedia-lib/tiff
"
BDEPEND="
	app-build/gettext
	app-core/debianutils
	app-dev/gtk-doc-am
	app-dev/pkgconf
	dev-python/docutils
	xgui-misc/shared-mime-info
"

src_configure() {
	local emesonargs=(
		-Dpng=enabled
		-Dothers=disabled
		-Dbuiltin_loaders=all
		-Dintrospection=enabled
		-Ddocs=false
		-Dgio_sniffing=false
		-Dtests=false
		-Drelocatable=false
	)
	meson_src_configure
}

src_install() {
	die
	meson_src_install
}

pkg_preinst() {
	die
	# Make sure loaders.cache belongs to gdk-pixbuf alone
	mkdir -p "${ED}"/usr/lib/${PN}-2.0/2.10.0/

	local cache="usr/lib/${PN}-2.0/2.10.0/loaders.cache"

	if [[ -e ${EROOT}/${cache} ]]; then
		cp "${EROOT}"/${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postinst() {
	ebegin "Updating gdk-pixbuf loader cache"
	gdk-pixbuf-query-loaders --update-cache
}
