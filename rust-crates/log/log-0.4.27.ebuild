# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="log"
CRATE_VERSION="0.4.27"
CRATE_CHECKSUM="13dc2df351e3202783a1fe0d44375f7295ffb4049267b0f3018346dc122a1d94"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight logging facade for Rust"
HOMEPAGE="https://github.com/rust-lang/log"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
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
	"std"
)
