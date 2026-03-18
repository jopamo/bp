# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="A simple, fast and user-friendly alternative to gnu find"
HOMEPAGE="https://github.com/sharkdp/fd"
SNAPSHOT=fcd846651bd2652f7d867f15e7159d085c2e7abc
SRC_URI="https://github.com/sharkdp/fd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
