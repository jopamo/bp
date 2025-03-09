# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit xdg cmake

DESCRIPTION="Lightweight Qt Plain-Text Editor"
HOMEPAGE="https://github.com/tsujan/FeatherPad"

SNAPSHOT=eb56a77aa2aebe5385fdca51969bbd4f8113b6ea
SRC_URI="https://github.com/tsujan/FeatherPad/archive/${SNAPSHOT}.tar.gz -> FeatherPad-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/FeatherPad-${SNAPSHOT}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtbase
	xgui-lib/qtsvg
	app-tex/hunspell
"

PATCHES=( "${FILESDIR}"/ebuild.patch )

src_install() {
	cmake_src_install
	insinto /etc/xdg/featherpad
	doins "${FILESDIR}"/fp.conf
}
