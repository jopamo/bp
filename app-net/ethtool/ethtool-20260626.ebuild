# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="https://www.kernel.org/pub/software/network/ethtool/"
SNAPSHOT=212a8baed6ac4bca87fd8133702fa7039419a97f
SRC_URI="https://github.com/1g4-mirror/ethtool/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

DEPEND="app-compression/xz-utils"

src_prepare() {
	default
	eautoreconf
}
