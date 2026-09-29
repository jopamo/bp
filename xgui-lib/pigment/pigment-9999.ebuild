# Distributed under the terms of the GNU General Public License v2

inherit meson git-r3

DESCRIPTION="GDK Pixbuf image loading and SVG rendering libraries"
HOMEPAGE="https://gitlab.com/pjo/pigment"
EGIT_REPO_URI="https://gitlab.com/pjo/pigment"

LICENSE="LGPL-2+ LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection"

DEPEND="
	fonts/fontconfig
	lib-core/glib
	lib-core/libxml2
	lib-misc/liblexa
	xgui-desktop/shared-mime-info
	xgui-lib/cairo
	xgui-lib/pango
	xmedia-lib/libjpeg-turbo
	xmedia-lib/libpng
	xmedia-lib/tiff
	introspection? ( lib-dev/gobject-introspection )
"
BDEPEND="
	app-build/gettext
	app-dev/pkgconf
	introspection? ( lib-dev/gobject-introspection )
"

src_configure() {
	local emesonargs=(
		-Dothers=enabled
		-Dbuiltin_loaders=all
		-Dsvg=true
		-Dgdk_pixbuf_loader=true
		$(meson_feature introspection)
	)
	meson_src_configure
}

pkg_preinst() {
	local moduledir="/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders"
	mkdir -p "${ED}${moduledir}" || die

	local cache="${moduledir}/loaders.cache"

	if [[ -e ${EROOT}${cache} ]]; then
		cp "${EROOT}${cache}" "${ED}${cache}" || die
	else
		: > "${ED}${cache}" || die
	fi
}

pkg_postinst() {
	[[ ${EROOT} == / ]] || return

	einfo "Updating gdk-pixbuf loader cache"
	GDK_PIXBUF_MODULEDIR="/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders" \
		gdk-pixbuf-query-loaders --update-cache || die
}
