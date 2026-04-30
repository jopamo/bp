# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap"
CRATE_VERSION="4.6.1"
CRATE_CHECKSUM="1ddb117e43bbf7dacf0a4190fef4d345b9bad68dfc649cb349e7d17d28428e51"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple to use, efficient, and full-featured Command Line Argument Parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cargo"
	"color"
	"debug"
	"default"
	"deprecated"
	"derive"
	"env"
	"error-context"
	"help"
	"std"
	"string"
	"suggestions"
	"unicode"
	"unstable-derive-ui-tests"
	"unstable-doc"
	"unstable-ext"
	"unstable-markdown"
	"unstable-styles"
	"unstable-v5"
	"usage"
	"wrap_help"
)
