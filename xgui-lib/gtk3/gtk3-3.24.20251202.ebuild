# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gtk-$(ver_cut 1)-$(ver_cut 2)"

inherit meson xdg

DESCRIPTION="Multi-platform toolkit for creating graphical user interfaces"
HOMEPAGE="https://www.gtk.org/"
SNAPSHOT=8723146fca06edd5584d0a9e16668356af6ce308

SRC_URI="https://gitlab.gnome.org/GNOME/gtk/-/archive/${SNAPSHOT}/gtk-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/gtk-${SNAPSHOT}"

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="cups introspection wayland X xinerama"

REQUIRED_USE="

	xinerama? ( X )
"

DEPEND="
	lib-util/glib
	xgui-misc/shared-mime-info
	xgui-lib/at-spi2-core
	xgui-lib/cairo[glib,svg,X?]
	xgui-lib/gdk-pixbuf
	xgui-lib/pango[introspection?]
	xmedia-lib/libepoxy[X(+)?]
	cups? ( lib-print/cups )
	introspection? ( lib-dev/gobject-introspection )
	wayland? ( xgui-lib/wayland-protocols )
	X? (
		xgui-lib/libX11
		xgui-lib/libXcomposite
		xgui-lib/libXcursor
		xgui-lib/libXdamage
		xgui-lib/libXext
		xgui-lib/libXfixes
		xgui-lib/libXi
		xgui-lib/libXrandr
		xinerama? ( xgui-lib/libXinerama )
	)
"
PDEPEND="
	xgui-lib/librsvg
	xgui-icontheme/adwaita-plus
"

src_configure() {
	local emesonargs=(
		$(meson_use X x11_backend)
		$(meson_use wayland wayland_backend)
		$(usex xinerama "-Dxinerama=yes" "-Dxinerama=no" )
		$(usex cups "-Dprint_backends=cups,file" "-Dprint_backends=file" )
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
