# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRANCH_NAME="gtk-$(ver_cut 1)-$(ver_cut 2)"

inherit meson xdg python-any-r1 flag-o-matic

DESCRIPTION="Gimp ToolKit +"
HOMEPAGE="https://www.gtk.org/"
SNAPSHOT=68df8c35f5eb4f9348cd2d87d4b62454c3a69b34
SRC_URI="https://github.com/GNOME/gtk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gtk-${SNAPSHOT}"

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="broadway cups ffmpeg examples introspection vim-syntax wayland X xinerama vulkan test sysprof colord build-examples demos build-tests"

REQUIRED_USE="
	|| ( wayland X )
	xinerama? ( X )
"

COMMON_DEPEND="
	fonts/fontconfig
	lib-util/glib
	xgui-lib/cairo[glib,svg,X?]
	xgui-lib/gdk-pixbuf
	xgui-lib/pango[introspection?]
	xgui-misc/shared-mime-info
	xmedia-lib/graphene
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
BDEPEND="app-lang/sassc"

pkg_setup() {
	use introspection && python-any-r1_pkg_setup
}

src_prepare() {
	use elibc_musl && sed -i '/#include <execinfo.h>/d' testsuite/reftests/gtk-reftest.c
	filter-flags -flto*
	filter-flags -Wl,-z,defs

	default
	xdg_environment_reset

	# Workaround RWX ELF sections, https://gitlab.gnome.org/GNOME/gtk/-/issues/4598
	sed -i -e 's/^ld =.*/ld = disabler()/g' gtk/meson.build demos/gtk-demo/meson.build demos/widget-factory/meson.build || die
	sed -i -e 's/^objcopy =.*/objcopy = disabler()/g' gtk/meson.build demos/gtk-demo/meson.build demos/widget-factory/meson.build || die
}

src_configure() {
	local emesonargs=(
		$(meson_feature colord)
		$(meson_feature cups print-cups)
		$(meson_feature introspection)
		$(meson_feature sysprof)
		$(meson_feature vulkan)
		$(meson_use X x11-backend)
		$(meson_use broadway broadway-backend)
		$(meson_use wayland wayland-backend)
		-Dcloudproviders=disabled
		-Dmacos-backend=false
		-Dman-pages=true
		-Dmedia-gstreamer=disabled
		-Dtracker=disabled  # tracker3 is not packaged in Gentoo yet
		-Dwin32-backend=false
		-Dbuild-demos=false
		-Dbuild-testsuite=false
		-Dbuild-examples=false
		-Dbuild-tests=false
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
