# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="log"
CRATE_VERSION="0.4.34"
CRATE_CHECKSUM="f9f8bd3e56ce4dfc153cf470fffbfa98c7620958b312ca5c3a4b8d5181fd13c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight logging facade for Rust"
HOMEPAGE="https://github.com/rust-lang/log"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"kv"
	"kv_serde"
	"kv_std"
	"kv_sval"
	"kv_unstable"
	"kv_unstable_serde"
	"kv_unstable_std"
	"kv_unstable_sval"
	"max_level_debug"
	"max_level_error"
	"max_level_info"
	"max_level_off"
	"max_level_trace"
	"max_level_warn"
	"release_max_level_debug"
	"release_max_level_error"
	"release_max_level_info"
	"release_max_level_off"
	"release_max_level_trace"
	"release_max_level_warn"
	"serde"
	"std"
)
