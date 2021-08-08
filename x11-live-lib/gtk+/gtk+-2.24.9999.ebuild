# Distributed under the terms of the GNU General Public License v2

EAPI=7

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
	>=lib-live/glib-2.49.4:2
	xmedia-live-lib/fontconfig
	>=xmedia-live-lib/libepoxy-1.0[X(+)?]
	>=xgui-live-lib/cairo-1.14[glib,svg,X?]
	>=x11-live-lib/gdk-pixbuf-2.30:2[introspection?]
	>=x11-live-lib/pango-1.37.3[introspection?]
	x11-live-misc/shared-mime-info
	cups? ( >=lib-print/cups-1.2 )
	introspection? ( >=lib-live/gobject-introspection-1.39:= )
	X? (
		x11-live-lib/libX11
		>=x11-live-lib/libXi-1.3
		x11-live-lib/libXext
		>=x11-live-lib/libXrandr-1.5
		x11-live-lib/libXcursor
		x11-live-lib/libXfixes
		x11-live-lib/libXcomposite
		x11-live-lib/libXdamage
		xinerama? ( x11-live-lib/libXinerama )
	)
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd
	lib-core/libxslt
	xgui-live-lib/at-spi2-atk
	lib-live/gobject-introspection-common
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19.7
	dev-util/pkgconf
	X? ( xinerama? ( x11-live-misc/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	xgui-live-lib/librsvg
	>=xgui-icontheme/adwaita-icon-theme-3.14
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
