# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit qmake-utils xdg

DESCRIPTION="Image Viewer and organizer"
HOMEPAGE="https://github.com/oferkv/phototonic"

SNAPSHOT=12552ece9564b1452606d653be67478ec6573ca1
SRC_URI="https://github.com/oferkv/phototonic/archive/${SNAPSHOT}.tar.gz -> phototonic-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/phototonic-${SNAPSHOT}"

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
