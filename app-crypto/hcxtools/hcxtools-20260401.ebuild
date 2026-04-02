# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxtools"
SNAPSHOT=35f132efec4eb0dd63ed273aa0ada5cea3645111
SRC_URI="https://github.com/ZerBea/hcxtools/archive/${SNAPSHOT}.tar.gz -> hcxtools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hcxtools-${SNAPSHOT}"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
