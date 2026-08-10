# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cargo git-r3

DESCRIPTION="openai compatible llm harness"
HOMEPAGE="https://gitlab.com/pjo/dive"
EGIT_REPO_URI="https://gitlab.com/pjo/dive"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 arm64"

RESTRICT="test network-sandbox"

src_compile() {
	local -x RUST_MIN_STACK=268435456
	local -x CARGO_PROFILE_RELEASE_LTO=off
	local -x CARGO_PROFILE_RELEASE_CODEGEN_UNITS=16

	cargo_src_compile --release -p codex-cli
}

src_install() {
	dobin target/release/dive
}
