# Distributed under the terms of the GNU General Public License v2

inherit prefix

DESCRIPTION="User land tool for cleaning up old perl installs"
HOMEPAGE="https://wiki.gentoo.org/wiki/Project:Perl"
SRC_URI="https://dev.gentoo.org/~dilfridge/distfiles/${PN}-2.31.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

RDEPEND="
	app-core/bash
	app-lang/perl
	app-core/corepkg
	app-core/coreq
"

PATCHES=( "${FILESDIR}"/perl-cleaner-bp.patch )

src_prepare() {
	default
	eprefixify "${PN}"
}

src_install() {
	dobin perl-cleaner
	doman perl-cleaner.1
}
