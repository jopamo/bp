# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="clap"
CRATE_VERSION="4.5.60"
CRATE_CHECKSUM="2797f34da339ce31042b27d23607e051786132987f595b02ba4f6a6dffb7030a"
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
