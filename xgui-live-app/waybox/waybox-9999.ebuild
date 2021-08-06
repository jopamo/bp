# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit meson git-r3 flag-o-matic

DESCRIPTION="An Openbox clone on Wayland (WIP)"
HOMEPAGE="https://github.com/wizbright/waybox"
EGIT_REPO_URI="https://github.com/wizbright/waybox.git"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs

DEPEND="
	|| ( xgui-live-lib/wlroots xgui-live-lib/wlroots-eglstreams )
"

src_prepare() {
	default
	sed -i 's/WLR_KEY_PRESSED/WL_KEYBOARD_KEY_STATE_PRESSED/g' waybox/seat.c
}
