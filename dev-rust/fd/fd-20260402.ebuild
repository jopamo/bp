# Distributed under the terms of the GNU General Public License v2

inherit cargo

DESCRIPTION="A simple, fast and user-friendly alternative to gnu find"
HOMEPAGE="https://github.com/sharkdp/fd"
SNAPSHOT=866ba9bfd52b0a0fef537afee285d0c0703aa48e
SRC_URI="https://github.com/sharkdp/fd/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
