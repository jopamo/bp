# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="gtk-$(ver_cut 1)-$(ver_cut 2)"

inherit meson xdg python-any-r1 flag-o-matic

DESCRIPTION="Multi-platform toolkit for creating graphical user interfaces"
HOMEPAGE="https://www.gtk.org/"
SNAPSHOT=0d41402a077a7504d11c7f52f2ad3806cbd4db62
SRC_URI="https://github.com/GNOME/gtk/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gtk-${SNAPSHOT}"

LICENSE="LGPL-2+"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

IUSE="broadway cups ffmpeg examples introspection vim-syntax wayland +X xinerama vulkan test sysprof colord build-examples demos build-tests"
RESTRICT="!test? ( test )"

REQUIRED_USE="
	|| ( broadway wayland X )
	xinerama? ( X )
"

COMMON_DEPEND="
	cups? ( lib-print/cups )
	fonts/fontconfig
	introspection? ( lib-dev/gobject-introspection )
	lib-core/glib
	xgui-desktop/shared-mime-info
	xgui-lib/cairo[glib,svg,X?]
	xgui-lib/pigment
	xgui-lib/pango[introspection?]
	xmedia-lib/graphene
	xmedia-lib/libepoxy[X(+)?]
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
	app-tex/docbookz
	lib-core/libxslt
	xgui-lib/at-spi2-core
	X? ( xinerama? ( xgui-tools/xorgproto ) )"

RDEPEND="${COMMON_DEPEND}"
PDEPEND="
	xgui-icontheme/adwaita-plus
	vim-syntax? ( app-tex/gtk-syntax )
"
BDEPEND="
	lib-dev/sass
	test? ( X? ( xgui-tools/xvfb-run ) )
"

PATCHES=(
	"${FILESDIR}/0001-notebook-balance-tab-label-references.patch"
	"${FILESDIR}/0002-gdkarray-avoid-wrapped-pointer-offsets-when-shrinking.patch"
	"${FILESDIR}/0003-css-use-typed-parse-option-predicates.patch"
	"${FILESDIR}/0004-css-release-replaced-calc-terms.patch"
	"${FILESDIR}/0005-tests-gate-waylandsocket-on-backend.patch"
)

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
		$(meson_use test build-testsuite)
		-Dbuild-examples=false
		$(meson_use test build-tests)
	)
	meson_src_configure
}

src_test() {
	if use X; then
		xvfb-run -a meson test -C "${BUILD_DIR}" --setup=x11 \
			--print-errorlogs --num-processes "$(makeopts_jobs)" \
			|| die "GTK tests failed"
	else
		meson_src_test
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
}

pkg_postrm() {
	xdg_pkg_postrm
}
