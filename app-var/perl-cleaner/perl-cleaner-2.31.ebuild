# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="User land tool for cleaning up old perl installs"
HOMEPAGE="https://www.gentoo.org/proj/en/perl/"
SRC_URI="mirror://gentoo/${P}.tar.bz2
		https://dev.gentoo.org/~dilfridge/distfiles/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	sed -i -e 's/@GENTOO_PORTAGE_EPREFIX@//g' perl-cleaner
}

src_install() {
	dobin perl-cleaner
	doman perl-cleaner.1
}
