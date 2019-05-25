# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools flag-o-matic virtualx git-r3

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://github.com/GNOME/gtk.git"
EGIT_BRANCH=gtk-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="3"
KEYWORDS="amd64 arm64"

IUSE="aqua broadway colord cups examples +introspection test vim-syntax wayland +X xinerama"

REQUIRED_USE="
	|| ( aqua wayland X )
	xinerama? ( X )
"

RESTRICT="test"

COMMON_DEPEND="
	gui-lib/atk[introspection?]
	>=lib-dev/glib-2.49.4:2
	lib-media/fontconfig
	>=lib-media/libepoxy-1.0[X(+)?]
	>=x11-libs/cairo-1.14[aqua?,glib,svg,X?]
	>=x11-libs/gdk-pixbuf-2.30:2[introspection?]
	>=x11-libs/pango-1.37.3[introspection?]
	x11-misc/shared-mime-info
	colord? ( >=x11/colord-0.1.9:0= )
	cups? ( >=lib-print/cups-1.2 )
	introspection? ( >=lib-dev/gobject-introspection-1.39:= )
	wayland? (
		>=lib-dev/wayland-1.9.91
		>=lib-dev/wayland-protocols-1.9
		lib-media/mesa[wayland]
		>=x11-libs/libxkbcommon-0.2
	)
	X? (
		>=gui-lib/at-spi2-atk-2.5.3
		x11-libs/libX11
		>=x11-libs/libXi-1.3
		x11-libs/libXext
		>=x11-libs/libXrandr-1.5
		x11-libs/libXcursor
		x11-libs/libXfixes
		x11-libs/libXcomposite
		x11-libs/libXdamage
		xinerama? ( x11-libs/libXinerama )
	)
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd
	lib-dev/libxslt
	lib-dev/gobject-introspection-common
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19.7
	dev-util/pkgconf
	X? ( xinerama? ( x11-misc/xorgproto ) )
	test? (
		fonts/font-misc-misc
		fonts/font-cursor-misc )
"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	gui-lib/librsvg
	>=gui-icontheme/adwaita-icon-theme-3.14
	vim-syntax? ( app-text/gtk-syntax )
"

src_prepare() {
	eautoreconf
	default
}

src_configure() {
	econf \
		$(use_enable aqua quartz-backend) \
		$(use_enable broadway broadway-backend) \
		$(use_enable colord) \
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
		--disable-mir-backend \
		--disable-papi \
		--with-xml-catalog="${EPREFIX}"/etc/xml/catalog \
		--libdir="${EPREFIX}"/usr/lib \
		CUPS_CONFIG="${EROOT}/usr/bin/cups-config"
}

src_test() {
	"${EROOT}/${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/gtk" || die
	GSETTINGS_SCHEMA_DIR="${S}/gtk" virtx emake check
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
		rm -f "${EROOT}"usr/lib/gtk-3.0/3.0.0/immodules.cache
	fi
}
