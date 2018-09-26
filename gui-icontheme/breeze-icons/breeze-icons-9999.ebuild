# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit cmake-multilib git-r3 gnome2-utils

DESCRIPTION="Breeze SVG icon theme"
LICENSE="LGPL-3"
KEYWORDS="amd64 arm64 x86"
SLOT=0

IUSE="test"
EGIT_REPO_URI="https://github.com/KDE/breeze-icons.git"

DEPEND="
	x11/extra-cmake-modules
	gui-lib/qtcore
	test? (
		gui-lib/qttest
		app-misc/fdupes
	)
"

src_configure() {
	local mycmakeargs=(
		-DBINARY_ICONS_RESOURCE=OFF
	)
	cmake-multilib_src_configure
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
