# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="wgpu-types"
CRATE_VERSION="29.0.1"
CRATE_CHECKSUM="ec2675540fb1a5cfa5ef122d3d5f390e2c75711a0b946410f2d6ac3a0f77d1f6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Common types and utilities for wgpu, the cross-platform, safe, pure-rust graphics API"
HOMEPAGE="https://wgpu.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"counters"
	"default"
	"fragile-send-sync-non-atomic-wasm"
	"serde"
	"std"
	"strict_asserts"
	"trace"
	"web"
)
