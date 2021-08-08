# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson

DESCRIPTION="Image loading library for GTK+"
HOMEPAGE="https://git.gnome.org/browse/gdk-pixbuf"

if [[ ${PV} == *9999 ]]; then
	EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/${PN}.git"
	inherit git-r3
else
	SNAPSHOT=b41548f1ce38a9dbc02703bf251a53f961107ef8
	SRC_URI="https://gitlab.gnome.org/GNOME/${PN}/-/archive/${SNAPSHOT}/${PN}-${SNAPSHOT}.tar.bz2 -> ${P}.tar.bz2"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

LICENSE="LGPL-2+"
SLOT="2"
KEYWORDS="amd64 arm64"

IUSE="+introspection"

DEPEND="
	lib-live/glib
	xmedia-live-lib/libpng
	xmedia-live-lib/libjpeg-turbo
	xmedia-live-lib/tiff
	x11-live-lib/libX11
"

BDEPEND="
	app-core/debianutils
	dev-util/gtk-doc-am
	sys-devel/gettext
	dev-util/pkgconf
	x11-live-misc/shared-mime-info
"

src_configure() {
	local emesonargs=(
		-Dbuiltin_loaders=all
		-Dintrospection=enabled
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

	pushd "${ED}" > /dev/null || die
	export GNOME2_ECLASS_GDK_PIXBUF_LOADERS=$(find usr/lib*/gdk-pixbuf-2.0 -type f 2>/dev/null)
	popd > /dev/null || die
}

pkg_postinst() {
	ebegin "Updating gdk-pixbuf loader cache"
	gdk-pixbuf-query-loaders --update-cache /usr/lib/gdk-pixbuf-2.0/2.10.0/loaders/*.so
}
