# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="minijinja"
CRATE_VERSION="2.15.1"
CRATE_CHECKSUM="b479616bb6f0779fb0f3964246beda02d4b01144e1b0d5519616e012ccc2a245"
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
