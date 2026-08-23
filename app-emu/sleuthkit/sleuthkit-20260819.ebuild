# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="a library and collection of command line digital forensics tools"
HOMEPAGE="https://www.sleuthkit.org/"
SNAPSHOT=c71437097f704ac149b60403d2a6ddc8c6a484f4
SRC_URI="https://github.com/sleuthkit/sleuthkit/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 arm64"

src_prepare() {
	default
	eautoreconf
}
