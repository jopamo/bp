# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit cmake-utils git-r3 xdg-utils

DESCRIPTION="Breeze SVG icon theme"
LICENSE="LGPL-3"
KEYWORDS="amd64 arm64"
SLOT=0

IUSE="test"
EGIT_REPO_URI="https://github.com/KDE/breeze-icons.git"

DEPEND="
	x11-misc/extra-cmake-modules
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
	cmake-utils_src_configure
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
