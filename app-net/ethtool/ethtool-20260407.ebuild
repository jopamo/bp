# Distributed under the terms of the GNU General Public License v2

inherit autotools

DESCRIPTION="Utility for examining and tuning ethernet-based network interfaces"
HOMEPAGE="https://www.kernel.org/pub/software/network/ethtool/"
SNAPSHOT=63bac8c4a386398c7b402aec25bde3c95aa0538b
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
