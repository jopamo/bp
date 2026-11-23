# Distributed under the terms of the GNU General Public License v2

BRANCH_NAME="gtksourceview-5-22"

inherit meson xdg

DESCRIPTION="Syntax highlighting source code editor widget for GTK"
HOMEPAGE="https://wiki.gnome.org/Projects/GtkSourceView"
SNAPSHOT=6959237de4623d8b4954cadbbde1078333d1aecf
SRC_URI="https://gitlab.gnome.org/GNOME/gtksourceview/-/archive/${SNAPSHOT}/gtksourceview-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/gtksourceview-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection test"
RESTRICT="!test? ( test )"

RDEPEND="
	>=lib-core/glib-2.76
	lib-core/libpcre2
	lib-core/libxml2
	lib-dev/fribidi
	>=xgui-lib/gtk4-4.17
	introspection? ( lib-dev/gobject-introspection )
"
DEPEND="${RDEPEND}
	test? ( xgui-lib/gtk4[X] )
"
BDEPEND="
	test? ( virtual/dbus xgui-tools/xvfb-run )
"

src_configure() {
	local emesonargs=(
		-Dbuild-testsuite=$(usex test true false)
		-Dvapi=false
		$(meson_feature introspection)
	)

	meson_src_configure
}

src_test() {
	GDK_BACKEND=x11 GTK_A11Y=none dbus-run-session -- xvfb-run -a \
		meson test -C "${BUILD_DIR}" --print-errorlogs || die
}
