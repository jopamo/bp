# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools git-r3 xdg

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
	fonts/fontconfig
	lib-live/glib
	xgui-live-app/shared-mime-info
	xgui-live-lib/cairo[glib,svg,X?]
	xgui-live-lib/gdk-pixbuf
	xgui-live-lib/pango[introspection?]
	xmedia-live-lib/libepoxy[X(+)?]
	cups? ( lib-print/cups )
	introspection? ( lib-live/gobject-introspection )
	wayland? (
		xgui-live-lib/libxkbcommon
		xgui-live-lib/wayland
		xgui-live-lib/wayland-protocols
		xgui-misc/mesa
	)
	X? (
		xgui-live-lib/libX11
		xgui-live-lib/libXcomposite
		xgui-live-lib/libXcursor
		xgui-live-lib/libXdamage
		xgui-live-lib/libXext
		xgui-live-lib/libXfixes
		xgui-live-lib/libXi
		xgui-live-lib/libXrandr
		xinerama? ( xgui-live-lib/libXinerama )
	)
"
DEPEND="${COMMON_DEPEND}
	app-build/gettext
	app-dev/gtk-doc-am
	app-dev/pkgconf
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libxslt
	lib-live/gobject-introspection-common
	xgui-live-lib/at-spi2-core
	X? ( xinerama? ( xgui-live-app/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	virtual/librsvg
	xgui-icontheme/adwaita-plus
	vim-syntax? ( app-tex/gtk-syntax )
"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable X x11-backend)
		$(use_enable X xcomposite)
		$(use_enable X xdamage)
		$(use_enable X xfixes)
		$(use_enable X xkb)
		$(use_enable X xrandr)
		$(use_enable broadway broadway-backend)
		$(use_enable cups)
		$(use_enable introspection)
		$(use_enable wayland wayland-backend)
		$(use_enable xinerama)
		--disable-colord
		--disable-papi
		--libdir="${EPREFIX}"/usr/lib
		--with-xml-catalog="${EPREFIX}"/etc/xml/catalog
		CUPS_CONFIG="${EROOT}/usr/bin/cups-config"
	)
	econf ${myconf[@]}
}

src_install() {
	default
	insopts -m 0755
	insinto /etc/gtk-3.0
	doins "${FILESDIR}"/settings.ini

	dosym -r /usr/include/gtk-3.0/gdk /usr/include/gdk
	dosym -r /usr/include/gtk-3.0/gtk /usr/include/gtk
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
