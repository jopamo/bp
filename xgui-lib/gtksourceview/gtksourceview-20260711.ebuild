# Distributed under the terms of the GNU General Public License v2

inherit meson xdg

DESCRIPTION="Syntax highlighting source code editor widget for GTK"
HOMEPAGE="https://wiki.gnome.org/Projects/GtkSourceView"
SNAPSHOT=f746b20cc050d5f0d39c3db3fe1705d80a09d7a4
SRC_URI="https://gitlab.gnome.org/GNOME/gtksourceview/-/archive/${SNAPSHOT}/gtksourceview-${SNAPSHOT}.tar.bz2"
S="${WORKDIR}/gtksourceview-${SNAPSHOT}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="introspection"

src_configure() {
	local emesonargs=(
		-Dbuild-testsuite=false
		-Dvapi=false
		$(meson_feature introspection)
	)

	meson_src_configure
}
