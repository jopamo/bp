# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="a compact, hackable compositor for Wayland based on wlroots."
HOMEPAGE="https://github.com/djpohly/dwl"
EGIT_REPO_URI="https://github.com/djpohly/dwl.git"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	|| ( xgui-live-lib/wlroots xgui-live-lib/wlroots-eglstreams )
"

src_install() {
	dobin dwl
}
