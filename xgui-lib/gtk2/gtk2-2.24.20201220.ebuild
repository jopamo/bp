# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gtk-$(ver_cut 1)-$(ver_cut 2)"

inherit autotools flag-o-matic xdg

DESCRIPTION="Multi-platform toolkit for creating graphical user interfaces"
HOMEPAGE="https://www.gtk.org/"

SNAPSHOT=68631945733158f164427db84f01301d7e875763
SRC_URI="https://gitlab.gnome.org/GNOME/gtk/-/archive/${SNAPSHOT}/gtk-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gtk-${SNAPSHOT}"

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="cups introspection vim-syntax X xinerama"

REQUIRED_USE="xinerama? ( X )"

COMMON_DEPEND="
	lib-util/glib
	fonts/fontconfig
	xmedia-lib/libepoxy[X(+)?]
	xgui-lib/cairo[glib,svg,X?]
	xgui-lib/gdk-pixbuf[introspection?]
	xgui-lib/pango[introspection?]
	xgui-misc/shared-mime-info
	cups? ( lib-print/cups )
	introspection? ( lib-dev/gobject-introspection )
	X? (
		xgui-lib/libX11
		xgui-lib/libXi
		xgui-lib/libXext
		xgui-lib/libXrandr
		xgui-lib/libXcursor
		xgui-lib/libXfixes
		xgui-lib/libXcomposite
		xgui-lib/libXdamage
		xinerama? ( xgui-lib/libXinerama )
	)
"
DEPEND="${COMMON_DEPEND}
	app-tex/docbook-xsl-stylesheets
	app-tex/docbook-xml-dtd
	lib-core/libxslt
	xgui-lib/at-spi2-core
	app-dev/gtk-doc-am
	app-build/gettext
	app-dev/pkgconf
	X? ( xinerama? ( xgui-tools/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"

PDEPEND="
	xgui-lib/librsvg
	xgui-icontheme/adwaita-plus
	vim-syntax? ( app-tex/gtk-syntax )
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
		CUPS_CONFIG="${BROOT}/usr/bin/cups-config"
}

src_install() {
	default

	rm "${ED}"/usr/bin/gtk-update-icon-cache
}

pkg_preinst() {
	xdg_pkg_preinst

	# Make immodules.cache belongs to gtk+ alone
	local cache="usr/lib/gtk-2.0/2.10.0/immodules.cache"

	if [[ -e ${EROOT}${cache} ]]; then
		cp "${EROOT}"${cache} "${ED}"/${cache} || die
	else
		touch "${ED}"/${cache} || die
	fi
}

pkg_postrm() {
	xdg_pkg_postrm

	if [[ -z ${REPLACED_BY_VERSION} ]]; then
		rm -f "${EROOT}"usr/lib/gtk-2.0/2.10.0/immodules.cache
	fi
}
