# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 xdg

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk.git"
EGIT_BRANCH=gtk-$(ver_cut 1)-$(ver_cut 2)

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="cups +introspection wayland +X xinerama"

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
	xgui-live-lib/at-spi2-core
	X? ( xinerama? ( xgui-live-app/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	virtual/librsvg
	xgui-icontheme/adwaita-plus
"

src_configure() {
	local emesonargs=(
		$(meson_use X x11_backend)
		$(meson_use wayland wayland_backend)
		$(usex xinerama "-Dxinerama=yes" "-Dxinerama=no" )
		$(usex cups "-Dprint_backends=cups" "-Dprint_backends=file" )
		$(meson_use introspection)
		-D demos=false
		-D examples=false
		-D broadway_backend=false
		-D cloudproviders=false
		-D tracker3=false
		-D colord=no
		-D gtk_doc=false
		-D man=true
		)
		meson_src_configure
}

src_install() {
	meson_src_install

	insopts -m 0755
	insinto /etc/gtk-$(ver_cut 1).0
	doins "${FILESDIR}"/settings.ini

	dosym -r /usr/include/gtk-$(ver_cut 1).0/gdk /usr/include/gdk
	dosym -r /usr/include/gtk-$(ver_cut 1).0/gtk /usr/include/gtk
}

pkg_preinst() {
	xdg_pkg_preinst

	# Make immodules.cache belongs to gtk+ alone
	local cache="usr/lib/gtk-$(ver_cut 1).0/$(ver_cut 1).0.0/immodules.cache"

	if [[ -e ${EROOT}/${cache} ]]; then
		cp "${EROOT}"/${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postrm() {
	xdg_pkg_postrm

	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		rm -f "${EROOT}"/usr/lib/gtk-$(ver_cut 1).0/$(ver_cut 1).0.0/immodules.cache
	fi
}
