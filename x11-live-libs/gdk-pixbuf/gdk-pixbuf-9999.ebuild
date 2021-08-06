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
	lib-dev/glib
	lib-media/libpng
	lib-media/libjpeg-turbo
	lib-media/tiff
	x11-live-libs/libX11
"

BDEPEND="
	sys-app/debianutils
	dev-util/gtk-doc-am
	sys-devel/gettext
	dev-util/pkgconf
	x11-live-misc/shared-mime-info
"

src_configure() {
	local emesonargs=(
		-Dpng=enabled
		-Dtiff=enabled
		-Djpeg=enabled
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
	unset __GL_NO_DSO_FINALIZER

	local updater="${EROOT%/}/usr/bin/${CHOST}-gdk-pixbuf-query-loaders"

	if [[ ! -x ${updater} ]]; then
		updater="${EROOT%/}/usr/bin/gdk-pixbuf-query-loaders"
	fi

	if [[ ! -x ${updater} ]]; then
		debug-print "${updater} is not executable"
		return
	fi

	if [[ -z ${GNOME2_ECLASS_GDK_PIXBUF_LOADERS} ]]; then
		debug-print "gdk-pixbuf loader cache does not need an update"
		return
	fi

	ebegin "Updating gdk-pixbuf loader cache"
	local tmp_file=$(mktemp)
	${updater} 1> "${tmp_file}" &&
	chmod 0644 "${tmp_file}" &&
	cp -f "${tmp_file}" "${EROOT%/}/usr/lib/gdk-pixbuf-2.0/2.10.0/loaders.cache" &&
	rm "${tmp_file}" # don't replace this with mv, required for SELinux support
	eend $?
}
