# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="ripgrep 13 compatibility build"
HOMEPAGE="https://github.com/jopamo/rg13"
SNAPSHOT=16c77eb6f37eed781faf2bc20b1a82530f6aa05c
SRC_URI="https://github.com/jopamo/rg13/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/rg13-${SNAPSHOT}"

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
