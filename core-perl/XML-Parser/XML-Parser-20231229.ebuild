# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit perl-module flag-o-matic

DESCRIPTION="A perl module for parsing XML documents"
HOMEPAGE="https://metacpan.org/release/XML-Parser"
SNAPSHOT=0384963609c270873196cc26b71c9490738ecc32
SRC_URI="https://github.com/cpan-authors/XML-Parser/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

SLOT="0"
KEYWORDS="amd64 arm64"

src_configure() {
	filter-flags -Wl,-z,defs

	myconf="EXPATLIBPATH=${EPREFIX}/usr/lib EXPATINCPATH=${EPREFIX}/usr/include"
	perl-module_src_configure
}
