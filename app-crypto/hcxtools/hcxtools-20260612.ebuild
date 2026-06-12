# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxtools"
SNAPSHOT=7a77c31db4669bc8ba0b846e776ae714e435c93c
SRC_URI="https://github.com/ZerBea/hcxtools/archive/${SNAPSHOT}.tar.gz -> hcxtools-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/hcxtools-${SNAPSHOT}"

EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

src_install(){
	emake DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
