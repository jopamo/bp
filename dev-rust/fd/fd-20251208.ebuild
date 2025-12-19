# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="A simple, fast and user-friendly alternative to gnu find"
HOMEPAGE="https://github.com/sharkdp/fd"
SNAPSHOT=f5b4171631c7615435b3e2275fff768c99e3c4f3
SRC_URI="https://github.com/sharkdp/fd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
