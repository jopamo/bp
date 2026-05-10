# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap"
CRATE_VERSION="4.5.54"
CRATE_CHECKSUM="c6e6ff9dcd79cff5cd969a17a545d79e84ab086e444102a591e288a8aa3ce394"
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
