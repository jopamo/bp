# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="ripgrep"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SNAPSHOT=9b84e154c8e404f4c40f6f4e4c674ea02e77324a
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
