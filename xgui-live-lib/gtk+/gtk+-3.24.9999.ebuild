# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools git-r3

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk.git"
EGIT_BRANCH=gtk-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="broadway cups +introspection vim-syntax wayland +X xinerama"

REQUIRED_USE="
	|| ( wayland X )
	xinerama? ( X )
"

COMMON_DEPEND="
	>=lib-live/glib-2.49.4:2
	xmedia-live-lib/fontconfig
	>=xmedia-live-lib/libepoxy-1.0[X(+)?]
	>=xgui-live-lib/cairo-1.14[glib,svg,X?]
	xgui-live-lib/gdk-pixbuf
	>=xgui-live-lib/pango-1.37.3[introspection?]
	xgui-live-app/shared-mime-info
	cups? ( >=lib-print/cups-1.2 )
	introspection? ( >=lib-live/gobject-introspection-1.39:= )
	wayland? (
		xgui-live-lib/wayland
		xgui-live-lib/wayland-protocols
		xmedia-live-lib/mesa
		>=xgui-live-lib/libxkbcommon-0.2
	)
	X? (
		xgui-live-lib/libX11
		>=xgui-live-lib/libXi-1.3
		xgui-live-lib/libXext
		>=xgui-live-lib/libXrandr-1.5
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
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19.7
	dev-util/pkgconf
	X? ( xinerama? ( xgui-live-app/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	xgui-live-lib/librsvg
	>=xgui-icontheme/adwaita-icon-theme-3.14
	vim-syntax? ( app-text/gtk-syntax )
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable broadway broadway-backend) \
		--disable-colord \
		$(use_enable cups) \
		$(use_enable introspection) \
		$(use_enable wayland wayland-backend) \
		$(use_enable X x11-backend) \
		$(use_enable X xcomposite) \
		$(use_enable X xdamage) \
		$(use_enable X xfixes) \
		$(use_enable X xkb) \
		$(use_enable X xrandr) \
		$(use_enable xinerama) \
		--disable-papi \
		--with-xml-catalog="${EPREFIX}"/etc/xml/catalog \
		--libdir="${EPREFIX}"/usr/lib \
		CUPS_CONFIG="${EROOT}/usr/bin/cups-config"
}

src_install() {
	default
	insinto /etc/gtk-3.0
	doins "${FILESDIR}"/settings.ini

	dosym /usr/include/gtk-3.0/gdk /usr/include/gdk
	dosym /usr/include/gtk-3.0/gtk /usr/include/gtk
}

pkg_preinst() {
	# Make immodules.cache belongs to gtk+ alone
	local cache="usr/lib/gtk-3.0/3.0.0/immodules.cache"

	if [[ -e ${EROOT}/${cache} ]]; then
		cp "${EROOT}"/${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postrm() {
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		rm -f "${EROOT}"/usr/lib/gtk-3.0/3.0.0/immodules.cache
	fi
}
