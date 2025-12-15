# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="intuitive find & replace CLI"
HOMEPAGE="https://github.com/jopamo/sd2"
SNAPSHOT=63e744e3b409a862a6ecc2b41ad40f3efe9745e1
SRC_URI="https://github.com/jopamo/sd2/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/"${PN}"
}
