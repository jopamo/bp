# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="An HTML5 parsing library in pure C99"
HOMEPAGE="https://github.com/google/gumbo-parser"

SNAPSHOT=a0f9059087c690e700cf42df4cfa58a63c1dae95
SRC_URI="https://github.com/google/gumbo-parser/archive/${SNAPSHOT}.tar.gz -> gumbo-parser-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/gumbo-parser-${SNAPSHOT}"

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
