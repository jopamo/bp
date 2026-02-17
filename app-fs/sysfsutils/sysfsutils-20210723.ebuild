# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools dot-a

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"

SNAPSHOT=085bba6bab1ccaa89041639a7e070390fdea440a
SRC_URI="https://github.com/linux-ras/sysfsutils/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/sysfsutils-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="static-libs"

src_prepare() {
	default
	sed -i 's:AM_CONFIG_HEADER:AC_CONFIG_HEADERS:' configure.ac || die
	eautoreconf
}

src_configure() {
	use static-libs && lto-guarantee-fat
	econf $(use_enable static-libs static)
}

src_install() {
	default
	use static-libs && strip-lto-bytecode
}
