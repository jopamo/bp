# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="subtle"
CRATE_VERSION="2.6.1"
CRATE_CHECKSUM="13c2bddecc57b384dee18652358fb23172facb8a2c51ccc10d74c157bdea3292"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure-Rust traits and utilities for constant-time cryptographic implementations."
HOMEPAGE="https://dalek.rs/"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"const-generics"
	"core_hint_black_box"
	"default"
	"i128"
	"nightly"
	"std"
)
