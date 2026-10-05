# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap"
CRATE_VERSION="4.5.56"
CRATE_CHECKSUM="a75ca66430e33a14957acc24c5077b503e7d374151b2b4b3a10c83b4ceb4be0e"
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
