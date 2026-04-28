# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap"
CRATE_VERSION="4.5.48"
CRATE_CHECKSUM="e2134bb3ea021b78629caa971416385309e0131b351b25e01dc16fb54e1b5fae"
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
