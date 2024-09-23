# Distributed under the terms of the GNU General Public License v2

EAPI=7

DIST_AUTHOR=TODDR
DIST_VERSION=2.46
inherit perl-module flag-o-matic

DESCRIPTION="A perl module for parsing XML documents"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs

src_configure() {
	myconf="EXPATLIBPATH=${EPREFIX}/usr/lib EXPATINCPATH=${EPREFIX}/usr/include"
	perl-module_src_configure
}
