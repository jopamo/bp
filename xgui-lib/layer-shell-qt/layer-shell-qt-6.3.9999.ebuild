# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake git-r3

DESCRIPTION="Qt component to allow applications to make use of the Wayland wl-layer-shell protocol"
HOMEPAGE="https://www.qt.io/"
EGIT_REPO_URI="https://github.com/KDE/layer-shell-qt.git"

LICENSE="|| ( GPL-2 GPL-3 LGPL-3 ) FDL-1.3"
SLOT="$(ver_cut 1)"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/qtwayland:6
	xgui-lib/qtdeclarative:6
"
