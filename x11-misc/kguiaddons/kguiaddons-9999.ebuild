# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 cmake-utils

DESCRIPTION="Framework providing assorted high-level user interface components"
EGIT_REPO_URI="https://github.com/KDE/kguiaddons.git"

LICENSE="LGPL-2+"
SLOT="0/1"
KEYWORDS="amd64 arm64"

RDEPEND="
	gui-lib/qtgui
	gui-lib/qtx11extras
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	x11-libs/libxcb
	x11-misc/xorgproto
	x11-misc/kf-env
"
