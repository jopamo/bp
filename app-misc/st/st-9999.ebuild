# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="a simple terminal implementation for X"
HOMEPAGE="https://st.suckless.org/"
EGIT_REPO_URI="https://git.suckless.org/st"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	virtual/curses
	xmedia-live-lib/fontconfig
	x11-live-lib/libX11
	x11-live-lib/libXft
	x11-live-misc/xorgproto
"

src_install() {
	dobin st
	doman st.1
}
