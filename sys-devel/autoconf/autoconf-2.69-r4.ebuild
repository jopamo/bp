# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Used to create autoconfiguration files"
HOMEPAGE="https://www.gnu.org/software/autoconf/autoconf.html"
SRC_URI="mirror://gnu/${PN}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND=">=sys-devel/m4-1.4.16
	>=dev-lang/perl-5.6"

PATCHES=(
		"${FILESDIR}"/${PN}-2.69-perl-5.26.patch
		"${FILESDIR}"/${P}-fix-libtool-test.patch
		"${FILESDIR}"/${PN}-2.69-perl-5.26-2.patch
	)
