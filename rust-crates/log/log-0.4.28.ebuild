# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="log"
CRATE_VERSION="0.4.28"
CRATE_CHECKSUM="34080505efa8e45a4b816c349525ebe327ceaa8559756f0356cba97ef3bf7432"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight logging facade for Rust"
HOMEPAGE="https://github.com/rust-lang/log"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

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
