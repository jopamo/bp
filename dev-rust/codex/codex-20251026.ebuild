# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="openai codex"
HOMEPAGE="https://github.com/openai/codex"
SNAPSHOT=bcd64c7e7231d6316a2377d1525a0fa74f21b783
SRC_URI="https://github.com/openai/codex/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/codex-${SNAPSHOT}/codex-rs"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_install() {
	dobin target/release/codex
}
