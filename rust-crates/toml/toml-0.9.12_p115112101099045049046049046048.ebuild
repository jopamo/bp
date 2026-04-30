# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="toml"
CRATE_VERSION="0.9.12+spec-1.1.0"
CRATE_CHECKSUM="cf92845e79fc2e2def6a5d828f0801e29a2f8acc037becc5ab08595c7d5e9863"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A native Rust encoder and decoder of TOML-formatted files and streams. Provides implementations of the standard Serialize/Deserialize traits for TOML data to facilitate deserializing and serializing Rust structures."
HOMEPAGE="https://github.com/toml-rs/toml"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"debug"
	"default"
	"display"
	"fast_hash"
	"parse"
	"preserve_order"
	"serde"
	"std"
	"unbounded"
)
