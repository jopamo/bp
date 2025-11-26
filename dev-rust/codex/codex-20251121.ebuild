# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo

DESCRIPTION="openai codex"
HOMEPAGE="https://github.com/openai/codex"
SNAPSHOT=b519267d05459095eccb9767c28550a2952d8a2f
SRC_URI="https://github.com/openai/codex/archive/${SNAPSHOT}.tar.gz -> ${PN}-${SNAPSHOT}.tar.gz"
S="${WORKDIR}/codex-${SNAPSHOT}/codex-rs"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_prepare() {
	default
	cp "${FILESDIR}"/*.md core/

	find . -type f -not -path '*/.git/*' \
		-exec sed -i 's/AGENTS\.md/HACKING.md/g' {} +
}

src_install() {
	dobin target/release/codex
}
