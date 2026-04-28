# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_core"
CRATE_VERSION="0.363.0"
CRATE_CHECKSUM="a88b80e430fa09d6e38b39930a8ede4c2cf5afcf272a2c1b3136a06849e37515"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A modern JavaScript/TypeScript runtime built with V8, Rust, and Tokio"
HOMEPAGE="https://github.com/denoland/deno_core"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"include_icu_data"
	"include_js_files_for_snapshotting"
	"snapshot_flags_eager_parse"
	"unsafe_runtime_options"
	"unsafe_use_unprotected_platform"
	"v8_enable_pointer_compression"
	"v8_enable_v8_checks"
	"v8_use_custom_libcxx"
)
