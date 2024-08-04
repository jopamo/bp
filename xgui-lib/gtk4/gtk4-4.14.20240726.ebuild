# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg python-any-r1 flag-o-matic

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"

SNAPSHOT=211a00e5e095fe04c22fd189f8b1781bd2d233d4
SRC_URI="https://github.com/GNOME/gtk/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/gtk-${SNAPSHOT}"

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="broadway cups ffmpeg examples +introspection vim-syntax wayland +X xinerama vulkan test sysprof colord build-examples demos build-tests"

REQUIRED_USE="
	|| ( wayland X )
	xinerama? ( X )
"

COMMON_DEPEND="
	fonts/fontconfig
	lib-util/glib
	xmedia-lib/graphene
	app-lang/sassc
	xgui-misc/shared-mime-info
	xgui-lib/cairo[glib,svg,X?]
	xgui-lib/gdk-pixbuf
	xgui-lib/pango[introspection?]
	xmedia-lib/libepoxy[X(+)?]
	cups? ( lib-print/cups )
	introspection? ( lib-dev/gobject-introspection )
	wayland? (
		xgui-lib/libxkbcommon
		xgui-lib/wayland
		xgui-lib/wayland-protocols
		xgui-tools/mesa
	)
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
DEPEND="${COMMON_DEPEND}
	app-build/gettext
	app-dev/gtk-doc-am
	app-dev/pkgconf
	app-tex/docbook-xml-dtd
	app-tex/docbook-xsl-stylesheets
	lib-core/libxslt
	xgui-lib/at-spi2-core
	X? ( xinerama? ( xgui-tools/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"
PDEPEND="
	xgui-lib/librsvg
	xgui-icontheme/adwaita-plus
	vim-syntax? ( app-tex/gtk-syntax )
"

pkg_setup() {
	use introspection && python-any-r1_pkg_setup
}

src_prepare() {
	filter-flags -flto*

	default
	xdg_environment_reset

	# Workaround RWX ELF sections, https://gitlab.gnome.org/GNOME/gtk/-/issues/4598
	sed -i -e 's/^ld =.*/ld = disabler()/g' gtk/meson.build demos/gtk-demo/meson.build demos/widget-factory/meson.build || die
	sed -i -e 's/^objcopy =.*/objcopy = disabler()/g' gtk/meson.build demos/gtk-demo/meson.build demos/widget-factory/meson.build || die
}

src_configure() {
	local emesonargs=(
		# GDK backends
		$(meson_use X x11-backend)
		$(meson_use wayland wayland-backend)
		$(meson_use broadway broadway-backend)
		-Dwin32-backend=false
		-Dmacos-backend=false

		# Media backends
		-Dmedia-gstreamer=disabled

		# Print backends
		$(meson_feature cups print-cups)

		# Optional dependencies
		$(meson_feature vulkan)
		-Dcloudproviders=disabled  # cloudprovider is not packaged in Gentoo yet
		$(meson_feature sysprof)
		-Dtracker=disabled  # tracker3 is not packaged in Gentoo yet
		$(meson_feature colord)

		# Documentation and introspection
		-Dgtk_doc=false # we ship pregenerated API docs from tarball
		-Dman-pages=true
		$(meson_feature introspection)

		# Demos and binaries
		$(meson_use examples build-examples)
		$(meson_use examples demos)
	)
	meson_src_configure
}

src_test() {
	"${BROOT}${GLIB_COMPILE_SCHEMAS}" --allow-any-name "${S}/gtk" || die

	if use X; then
		einfo "Running tests under X"
		GSETTINGS_SCHEMA_DIR="${S}/gtk" virtx meson_src_test --setup=x11
	fi

	if use wayland; then
		einfo "Running tests under Weston"

		export XDG_RUNTIME_DIR="$(mktemp -p $(pwd) -d xdg-runtime-XXXXXX)"

		weston --backend=headless-backend.so --socket=wayland-5 --idle-time=0 &
		compositor=$!
		export WAYLAND_DISPLAY=wayland-5

		GSETTINGS_SCHEMA_DIR="${S}/gtk" meson_src_test --setup=wayland

		exit_code=$?
		kill ${compositor}
	fi
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
