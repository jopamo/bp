# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils git-r3 xdg

DESCRIPTION="Image Viewer and organizer"
HOMEPAGE="https://github.com/oferkv/phototonic"
EGIT_REPO_URI="https://github.com/oferkv/phototonic.git"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="svg tiff"

DEPEND="
	xgui-lib/qtbase
	xmedia-live-app/exiv2
	svg? ( xgui-lib/qtsvg )
	tiff? ( xgui-lib/qtimageformats )
"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
