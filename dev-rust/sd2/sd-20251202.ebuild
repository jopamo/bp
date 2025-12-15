# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="intuitive find & replace CLI"
HOMEPAGE="https://github.com/jopamo/sd2"
SNAPSHOT=d0d909da07f7894072a67ca68f42ac8d6f0f5802
SRC_URI="https://github.com/jopamo/sd2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
