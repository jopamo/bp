# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="X.Org font encodings"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/font/encodings.git"

LICENSE="XORG"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="
	fonts/font-util
	xgui-live-app/mkfontscale
"

src_prepare() {
	default
	eautoreconf
}
