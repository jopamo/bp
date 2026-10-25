# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
SNAPSHOT=6dc11f43753c584fc795eaa34b6af21a359fa61c
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${SNAPSHOT}.tar.gz -> hcxdumptool-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hcxdumptool-${SNAPSHOT}"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
