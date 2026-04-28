# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="foreign-types"
CRATE_VERSION="0.5.0"
CRATE_CHECKSUM="d737d9aa519fb7b749cbc3b962edcf310a8dd1f4b67c91c4f83975dbdd17d965"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A framework for Rust wrappers over C APIs"
HOMEPAGE="https://github.com/sfackler/foreign-types"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
