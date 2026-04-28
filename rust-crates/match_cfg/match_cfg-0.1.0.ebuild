# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="match_cfg"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="ffbee8634e0d45d258acb448e7eaab3fce7a0a467395d4d9f228e3c1f01fb2e4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A convenience macro to ergonomically define an item depending on a large number of \`#[cfg]\` parameters. Structured like match statement, the first matching branch is the item that gets emitted."
HOMEPAGE="https://github.com/gnzlbg/match_cfg"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"use_core"
)
