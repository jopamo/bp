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
	>=lib-sys/ncurses-6.0:0=
	lib-media/fontconfig
	x11-libs/libX11
	x11-libs/libXft
	x11-misc/xorgproto
"

src_install() {
	dobin st
	doman st.1
}
