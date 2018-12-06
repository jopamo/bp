# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit cmake-utils

DESCRIPTION="Common base library for the LXQt desktop environment"
HOMEPAGE="http://lxqt.org/"

if [[ ${PV} = *9999* ]]; then
	inherit git-r3
	EGIT_REPO_URI="http://www.github.com/lxqt/${PN}.git"
else
	SRC_URI="https://github.com/lxqt/liblxqt/releases/download/${PV}/${P}.tar.xz"
fi

LICENSE="GPL-2 LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 arm64 x86"

RDEPEND=">=lib-dev/libqtxdg-1.3.0
	gui-lib/qtcore:5
	gui-lib/qtdbus:5
	gui-lib/qtgui:5
	gui-lib/qtwidgets:5
	gui-lib/qtx11extras:5
	gui-lib/qtxml:5
	x11/kwindowsystem
	lib-dev/libqtxdg
	x11-libs/libXScrnSaver"
DEPEND="${RDEPEND}
	gui-lib/linguist-tools:5"
	
PATCHES=( ${FILESDIR}/remove_polkit.patch )

src_configure() {
	cmake-utils_src_configure
}
