# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 autotools

DESCRIPTION="An HTML5 parsing library in pure C99"
HOMEPAGE="https://github.com/google/gumbo-parser"
EGIT_REPO_URI="https://github.com/google/gumbo-parser"

LICENSE="apache"
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
		--disable-silent-rules
	)
	ECONF_SOURCE=${S} econf "${myconf[@]}"
}
