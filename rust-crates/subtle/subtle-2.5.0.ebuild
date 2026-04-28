# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="subtle"
CRATE_VERSION="2.5.0"
CRATE_CHECKSUM="81cdd64d312baedb58e21336b31bc043b77e01cc99033ce76ef539f78e965ebc"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure-Rust traits and utilities for constant-time cryptographic implementations."
HOMEPAGE="https://dalek.rs/"
LICENSE="BSD-3-Clause"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"const-generics"
	"core_hint_black_box"
	"default"
	"i128"
	"nightly"
	"std"
)
