# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="X.Org font encodings"

KEYWORDS="amd64 arm64"
EGIT_REPO_URI="https://github.com/freedesktop/xorg-encodings.git"
SLOT=0

DEPEND="xgui-live-app/mkfontscale
	>=fonts/font-util-1.1.1-r1"

src_prepare() {
	eautoreconf
	default
}
