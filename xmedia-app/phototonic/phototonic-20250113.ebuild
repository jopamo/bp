# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Image Viewer and organizer"
HOMEPAGE="https://github.com/oferkv/phototonic"

SNAPSHOT=6d3f8f6f2a1fed57ca856e4e2a3e49ab18bc6e39
SRC_URI="https://github.com/oferkv/phototonic/archive/${SNAPSHOT}.tar.gz -> phototonic-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/phototonic-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="svg tiff"

DEPEND="
	xgui-lib/qtbase
	xmedia-lib/exiv2
	svg? ( xgui-lib/qtsvg )
	tiff? ( xgui-lib/qtimageformats )
"

src_configure() {
	eqmake5
}

src_install() {
	emake install INSTALL_ROOT="${D}"
}
