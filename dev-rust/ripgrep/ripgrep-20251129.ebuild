# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="recursively searches for a regex pattern while respecting your gitignore"
HOMEPAGE="https://github.com/BurntSushi/ripgrep"
SNAPSHOT=cd1f981beafaeb9b61537e47e91314cea125400b
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
