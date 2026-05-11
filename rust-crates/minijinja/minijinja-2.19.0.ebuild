# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="minijinja"
CRATE_VERSION="2.19.0"
CRATE_CHECKSUM="805bfd7352166bae857ee569628b52bcd85a1cecf7810861ebceb1686b72b75d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="a powerful template engine for Rust with minimal dependencies"
HOMEPAGE="https://github.com/mitsuhiko/minijinja"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"adjacent_loop_items"
	"builtins"
	"custom_syntax"
	"debug"
	"default"
	"deserialization"
	"fuel"
	"internal_debug"
	"internal_safe_search"
	"json"
	"key_interning"
	"loader"
	"loop_controls"
	"macros"
	"multi_template"
	"preserve_order"
	"serde"
	"speedups"
	"std_collections"
	"unicode"
	"unstable_machinery"
	"unstable_machinery_serde"
	"urlencode"
)
