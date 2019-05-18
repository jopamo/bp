# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools toolchain-funcs

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"
SRC_URI="mirror://sourceforge/linux-diag/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	sed -i 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die
	AT_M4DIR=m4 eautoreconf
}

src_configure() {
	econf $(use_enable static-libs static)
}
