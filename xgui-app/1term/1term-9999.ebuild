# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson git-r3 xdg

DESCRIPTION="VTE/GTK4 terminal emulator"
HOMEPAGE="https://github.com/jopamo/1term"
EGIT_REPO_URI="https://github.com/jopamo/1term"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	xgui-lib/vte
	xgui-lib/gtk4
"
