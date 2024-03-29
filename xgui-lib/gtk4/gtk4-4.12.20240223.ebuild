# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 xdg python-any-r1

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
EGIT_REPO_URI="https://gitlab.gnome.org/GNOME/gtk.git"
EGIT_BRANCH=gtk-$(ver_cut 1)-$(ver_cut 2)

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
	dev-python/pygobject
	xgui-live-lib/at-spi2-core
	X? ( xinerama? ( xgui-live-app/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"
BDEPEND="
	app-live/sassc
"
PDEPEND="
	virtual/librsvg
	xgui-icontheme/adwaita-plus
	vim-syntax? ( app-tex/gtk-syntax )
"

pkg_setup() {
	use introspection && python-any-r1_pkg_setup
}

src_prepare() {
	default
	xdg_environment_reset

	# dev-python/docutils installs rst2man.py, not rst2man
	sed -i -e "s/'rst2man'/'rst2man.py'/" docs/reference/gtk/meson.build || die
	# Nothing should use gtk4-update-icon-cache and an unversioned one is shipped by dev-util/gtk-update-icon-cache
	sed -i -e '/gtk4-update-icon-cache/d' tools/meson.build || die
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
		$(meson_feature ffmpeg media-ffmpeg)
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
		$(meson_use test build-tests)
		-Dinstall-tests=false
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
