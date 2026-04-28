# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wgpu-types"
CRATE_VERSION="24.0.0"
CRATE_CHECKSUM="50ac044c0e76c03a0378e7786ac505d010a873665e2d51383dcff8dd227dc69c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common types and utilities for wgpu, the cross-platform, safe, pure-rust graphics API"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"counters"
	"default"
	"fragile-send-sync-non-atomic-wasm"
	"serde"
	"std"
	"strict_asserts"
)
