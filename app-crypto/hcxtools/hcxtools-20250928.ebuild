# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxtools"
SNAPSHOT=0e026895b73a278847120d46c9296670a871450a
SRC_URI="https://github.com/ZerBea/hcxtools/archive/${SNAPSHOT}.tar.gz -> hcxtools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hcxtools-${SNAPSHOT}"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
