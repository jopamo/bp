# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="Small tool to capture packets from wlan devices"
HOMEPAGE="https://github.com/ZerBea/hcxdumptool"
EGIT_REPO_URI="https://github.com/ZerBea/hcxdumptool.git"
EGIT_SUBMODULES=()

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm64"

IUSE="gpio"

src_configure(){
	local GPIOSUPPORT
	if use gpio; then
		GPIOSUPPORT="GPIOSUPPORT=on"
	fi
	emake ${GPIOSUPPORT}
}

src_install(){
	emake ${GPIOSUPPORT} DESTDIR="${ED}" PREFIX="${EPREFIX}/usr" install
}
