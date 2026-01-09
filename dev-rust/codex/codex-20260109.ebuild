# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="openai codex"
HOMEPAGE="https://github.com/openai/codex"
SNAPSHOT=af1ed2685e26637615ff7a7033b8a219b2bb99cb
SRC_URI="https://github.com/openai/codex/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/codex-${SNAPSHOT}/codex-rs"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_prepare() {
	export RUST_MIN_STACK=134217728

	default
	cp "${FILESDIR}"/*.md core/

	find . -type f -not -path '*/.git/*' \
		-exec sed -i 's/AGENTS\.md/HACKING.md/g' {} +
}

src_install() {
	dobin target/release/codex
}
