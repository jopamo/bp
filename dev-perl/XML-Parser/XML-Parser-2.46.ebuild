# Distributed under the terms of the GNU General Public License v2

EAPI=5

MODULE_AUTHOR=TODDR

inherit perl-module flag-o-matic

DESCRIPTION="A Perl extension interface to James Clark's XML parser, expat"

SLOT="0"
KEYWORDS="amd64 arm64"

filter-flags -Wl,-z,defs

src_configure() {
	myconf="EXPATLIBPATH=${EPREFIX}/usr/lib EXPATINCPATH=${EPREFIX}/usr/include"
	perl-module_src_configure
}
