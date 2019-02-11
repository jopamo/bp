# Distributed under the terms of the GNU General Public License v2

EAPI=6

CMAKE_MAKEFILE_GENERATOR=ninja

inherit cmake-utils xdg-utils git-r3

DESCRIPTION="Fast and usable calculator for power users"
HOMEPAGE="http://speedcrunch.org/"
EGIT_REPO_URI="https://bitbucket.org/heldercorreia/speedcrunch.git"
KEYWORDS="amd64 arm64"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="
gui-lib/qtcore:5
gui-lib/qthelp:5
gui-lib/qtsql:5
gui-lib/qtwidgets:5
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
}

