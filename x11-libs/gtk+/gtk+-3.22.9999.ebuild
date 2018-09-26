# Distributed under the terms of the GNU General Public License v2

EAPI=6
GNOME2_LA_PUNT="yes"

inherit autotools flag-o-matic multilib virtualx multilib-minimal git-r3

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"

EGIT_REPO_URI="https://github.com/GNOME/gtk.git"
EGIT_BRANCH=gtk-3-22

LICENSE="LGPL-2+"
SLOT="3"
IUSE="aqua broadway colord cups examples +introspection test vim-syntax wayland +X xinerama"
REQUIRED_USE="
	|| ( aqua wayland X )
	xinerama? ( X )
"

KEYWORDS="amd64 arm64 x86"

# Upstream wants us to do their job:
# https://bugzilla./show_bug.cgi?id=768662#c1
RESTRICT="test"

# FIXME: introspection data is built against system installation of gtk+:3,
# bug #????
COMMON_DEPEND="
	gui-lib/atk[introspection?,${MULTILIB_USEDEP}]
	>=lib-dev/glib-2.49.4:2[${MULTILIB_USEDEP}]
	lib-media/fontconfig[${MULTILIB_USEDEP}]
	>=lib-media/libepoxy-1.0[X(+)?,${MULTILIB_USEDEP}]
	>=x11-libs/cairo-1.14[aqua?,glib,svg,X?,${MULTILIB_USEDEP}]
	>=x11-libs/gdk-pixbuf-2.30:2[introspection?,${MULTILIB_USEDEP}]
	>=x11-libs/pango-1.37.3[introspection?,${MULTILIB_USEDEP}]
	x11/shared-mime-info
	colord? ( >=x11/colord-0.1.9:0=[${MULTILIB_USEDEP}] )
	cups? ( >=lib-print/cups-1.2[${MULTILIB_USEDEP}] )
	introspection? ( >=lib-dev/gobject-introspection-1.39:= )
	wayland? (
		>=lib-dev/wayland-1.9.91[${MULTILIB_USEDEP}]
		>=lib-dev/wayland-protocols-1.9
		lib-media/mesa[wayland,${MULTILIB_USEDEP}]
		>=x11-libs/libxkbcommon-0.2[${MULTILIB_USEDEP}]
	)
	X? (
		>=gui-lib/at-spi2-atk-2.5.3[${MULTILIB_USEDEP}]
		x11-libs/libX11[${MULTILIB_USEDEP}]
		>=x11-libs/libXi-1.3[${MULTILIB_USEDEP}]
		x11-libs/libXext[${MULTILIB_USEDEP}]
		>=x11-libs/libXrandr-1.5[${MULTILIB_USEDEP}]
		x11-libs/libXcursor[${MULTILIB_USEDEP}]
		x11-libs/libXfixes[${MULTILIB_USEDEP}]
		x11-libs/libXcomposite[${MULTILIB_USEDEP}]
		x11-libs/libXdamage[${MULTILIB_USEDEP}]
		xinerama? ( x11-libs/libXinerama[${MULTILIB_USEDEP}] )
	)
"
DEPEND="${COMMON_DEPEND}
	app-text/docbook-xsl-stylesheets
	app-text/docbook-xml-dtd
	lib-dev/libxslt
	lib-dev/gobject-introspection-common
	>=dev-util/gtk-doc-am-1.20
	>=sys-devel/gettext-0.19.7[${MULTILIB_USEDEP}]
	dev-util/pkgconfig[${MULTILIB_USEDEP}]
	X? ( xinerama? ( x11/xorgproto[${MULTILIB_USEDEP}] ) )
	test? (
		fonts/font-misc-misc
		fonts/font-cursor-misc )
"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	gui-lib/librsvg[${MULTILIB_USEDEP}]
	>=gui-icontheme/adwaita-icon-theme-3.14
	vim-syntax? ( app-text/gtk-syntax )
"

MULTILIB_CHOST_TOOLS=(
	/usr/bin/gtk-query-immodules-3.0$(get_exeext)
)

src_prepare() {
	eautoreconf
	default
	multilib_copy_sources
}

multilib_src_configure() {
	econf \
		$(use_enable aqua quartz-backend) \
		$(use_enable broadway broadway-backend) \
		$(use_enable colord) \
		$(use_enable cups cups auto) \
		$(multilib_native_use_enable introspection) \
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
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		CUPS_CONFIG="${EPREFIX}/usr/bin/${CHOST}-cups-config"

	# work-around gtk-doc out-of-source brokedness
	if multilib_is_native_abi; then
		local d
		for d in gdk gtk libgail-util; do
			ln -s "${S}"/docs/reference/${d}/html docs/reference/${d}/html || die
		done
	fi
}

multilib_src_test() {
	"${EROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/gtk" || die
	GSETTINGS_SCHEMA_DIR="${S}/gtk" virtx emake check
}


multilib_src_install_all() {
	insinto /etc/gtk-3.0
	doins "${FILESDIR}"/settings.ini
}

pkg_preinst() {
	multilib_pkg_preinst() {
		# Make immodules.cache belongs to gtk+ alone
		local cache="usr/$(get_libdir)/gtk-3.0/3.0.0/immodules.cache"

		if [[ -e ${EROOT}${cache} ]]; then
			cp "${EROOT}"${cache} "${ED}"/${cache} || die
		else
			touch "${ED}"/${cache} || die
		fi
	}
	multilib_parallel_foreach_abi multilib_pkg_preinst
}

pkg_postinst() {
	multilib_parallel_foreach_abi multilib_pkg_postinst
}

pkg_postrm() {
	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		multilib_pkg_postrm() {
			rm -f "${EROOT}"usr/$(get_libdir)/gtk-3.0/3.0.0/immodules.cache
		}
		multilib_foreach_abi multilib_pkg_postrm
	fi
}
