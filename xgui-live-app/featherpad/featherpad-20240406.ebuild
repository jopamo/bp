# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Lightweight Qt5 Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"

SNAPSHOT=58fc8dfaa6be0188bcfe727667f5d37cf80be331
SRC_URI="https://github.com/tsujan/FeatherPad/archive/${SNAPSHOT}.tar.gz -> FeatherPad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/FeatherPad-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase:6
	xgui-lib/qtsvg:6
	app-tex/hunspell
"

PATCHES=( "${FILESDIR}"/ebuild.patch )

src_install() {
	cmake_src_install
	insinto /etc/xdg/featherpad
	doins "${FILESDIR}"/fp.conf
}
