# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit autotools

DESCRIPTION="System Utilities Based on Sysfs"
HOMEPAGE="http://linux-diag.sourceforge.net/Sysfsutils.html"

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/linux-ras/sysfsutils.git"
	inherit git-r3
else
	SNAPSHOT=ce2870e61996b4e86203d4663f1c041e7a5fd3bd
	SRC_URI="https://github.com/linux-ras/sysfsutils/archive/${SNAPSHOT}.tar.gz -> ${P}.tar.gz"
	S=${WORKDIR}/${PN}-${SNAPSHOT}
fi

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
	econf $(use_enable static-libs static)
}
