# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="command-line benchmarking tool"
HOMEPAGE="https://github.com/sharkdp/hyperfine"
SNAPSHOT=975fe108c4ee7bd2600d10758207b44ca3dae738
SRC_URI="https://github.com/sharkdp/hyperfine/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
