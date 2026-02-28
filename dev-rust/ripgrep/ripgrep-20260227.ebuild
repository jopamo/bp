# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="ripgrep"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SNAPSHOT=4519153e5e461527f4bca45b042fff45c4ec6fb9
SRC_URI="https://github.com/BurntSushi/ripgrep/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/${PN}-${SNAPSHOT}"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_compile() {
	cargo build --release --features 'pcre2'
}

src_install() {
	dobin target/release/rg
}
