# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="command-line benchmarking tool"
HOMEPAGE="https://github.com/sharkdp/hyperfine"
SNAPSHOT=327d5f4d9107141929f67f062bf9ef59f98b7399
SRC_URI="https://github.com/sharkdp/hyperfine/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
