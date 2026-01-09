# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="A simple, fast and user-friendly alternative to gnu find"
HOMEPAGE="https://github.com/sharkdp/fd"
SNAPSHOT=5f95a781212e3efbc6d91ae50e0ca0ce0693da50
SRC_URI="https://github.com/sharkdp/fd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
