# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="a library and collection of command line digital forensics tools"
HOMEPAGE="https://www.sleuthkit.org/"
SNAPSHOT=70d07bd57d8bb4bd932301a5adfb08ab02d0ecfb
SRC_URI="https://github.com/sleuthkit/sleuthkit/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
