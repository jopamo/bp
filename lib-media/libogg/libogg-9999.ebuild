# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3 autotools

DESCRIPTION="the Ogg media file format library"
HOMEPAGE="https://xiph.org/ogg/"
EGIT_REPO_URI="https://github.com/xiph/ogg.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	eautoreconf
}


src_configure() {
	local myconf=(
		$(use_enable static-libs static)
		)
	ECONF_SOURCE="${S}" econf "${myconf[@]}"
}
