# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="intuitive find & replace CLI"
HOMEPAGE="https://github.com/jopamo/stedi"
SNAPSHOT=50d80c438951db9a80f7cb953e7a683df886bf4f
SRC_URI="https://github.com/jopamo/txed/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
