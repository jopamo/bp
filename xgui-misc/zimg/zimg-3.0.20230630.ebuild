# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Scaling, colorspace conversion, and dithering library"
HOMEPAGE="https://github.com/sekrit-twc/zimg"
EGIT_REPO_URI="https://github.com/sekrit-twc/zimg"
EGIT_BRANCH="v$(ver_cut 1).$(ver_cut 2)"

LICENSE="WTFPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="debug static-libs"

src_prepare() {
	default
	eautoreconf
}

src_configure() {
	local myconf=(
		$(use_enable debug)
		$(use_enable static-libs static)
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
