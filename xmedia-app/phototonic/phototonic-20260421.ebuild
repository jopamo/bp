# Distributed under the terms of the GNU General Public License v2

inherit qmake-utils qa-policy xdg

DESCRIPTION="Image Viewer and organizer"
HOMEPAGE="https://github.com/luebking/phototonic"

SNAPSHOT=821c6132324444fcffc0a1fb0da5e7aa49e0bf6a
SRC_URI="https://github.com/luebking/phototonic/archive/${SNAPSHOT}.tar.gz -> phototonic-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/phototonic-${SNAPSHOT}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="svg tiff"

DEPEND="
	xgui-lib/qtbase:6
	xmedia-lib/exiv2
	svg? ( xgui-lib/qtsvg:6 )
	tiff? ( xgui-lib/qtimageformats:6 )
"

src_configure() {
	qa-policy-configure
	eqmake6
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	qa-policy-install
}
