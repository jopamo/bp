# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="X.Org bitmaps data"
EGIT_REPO_URI="https://gitlab.freedesktop.org/xorg/data/bitmaps.git"

LICENSE="MIT"
SLOT="0/1"
KEYWORDS="amd64 arm64"

src_prepare() {
	eautoreconf
	default
}
