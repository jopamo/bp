# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson xdg

DESCRIPTION="Syntax highlighting source code editor widget for GTK"
HOMEPAGE="https://www.x.org/wiki/"
SNAPSHOT=2368a3af1c5950f8571d538da3593767ebd68171
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
