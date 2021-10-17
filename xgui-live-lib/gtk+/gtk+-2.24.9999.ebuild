# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools flag-o-matic git-r3

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk.git"
EGIT_BRANCH=gtk-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="cups +introspection vim-syntax +X xinerama"

REQUIRED_USE="xinerama? ( X )"

COMMON_DEPEND="
	lib-live/glib
	fonts/fontconfig
	xmedia-live-lib/libepoxy[X(+)?]
	xgui-live-lib/cairo[glib,svg,X?]
	xgui-live-lib/gdk-pixbuf[introspection?]
	xgui-live-lib/pango[introspection?]
	xgui-live-app/shared-mime-info
	cups? ( lib-print/cups )
	introspection? ( lib-live/gobject-introspection )
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXi
		xgui-live-lib/libXext
		xgui-live-lib/libXrandr
		xgui-live-lib/libXcursor
		xgui-live-lib/libXfixes
		xgui-live-lib/libXcomposite
		xgui-live-lib/libXdamage
		xinerama? ( xgui-live-lib/libXinerama )
	)
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd
	lib-core/libxslt
	xgui-live-lib/at-spi2-atk
	lib-live/gobject-introspection-common
	dev-util/gtk-doc-am
	sys-devel/gettext
	dev-util/pkgconf
	X? ( xinerama? ( xgui-live-app/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	xgui-live-lib/librsvg
	xgui-icontheme/adwaita-plus
	vim-syntax? ( app-text/gtk-syntax )
"

filter-flags -flto\=\* -Wl,-z,defs

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable cups) \
		$(use_enable introspection) \
		$(use_enable X xkb) \
		$(use_enable xinerama) \
		--disable-papi \
		--with-xml-catalog="${EPREFIX}"/etc/xml/catalog \
		--libdir="${EPREFIX}"/usr/lib \
		CUPS_CONFIG="${EROOT}/usr/bin/cups-config"
}

src_install() {
	default

	rm "${ED}"/usr/bin/gtk-update-icon-cache
}

pkg_preinst() {
	# Make immodules.cache belongs to gtk+ alone
	local cache="usr/lib/gtk-2.0/2.10.0/immodules.cache"

	if [[ -e ${EROOT}${cache} ]]; then
		cp "${EROOT}"${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postrm() {
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		rm -f "${EROOT}"usr/lib/gtk-2.0/2.10.0/immodules.cache
	fi
}
