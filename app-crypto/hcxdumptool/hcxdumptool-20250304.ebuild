# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"

SNAPSHOT=c662c6f446e75830c5ff73100716400707e4d5ca
SRC_URI="https://github.com/ZerBea/hcxdumptool/archive/${SNAPSHOT}.tar.gz -> hcxdumptool-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hcxdumptool-${SNAPSHOT}"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
