# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
SNAPSHOT=dc0620ba6d4f71e982dae4b53c4a170dd2ecd7ca
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${SNAPSHOT}.tar.gz -> hcxdumptool-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hcxdumptool-${SNAPSHOT}"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
