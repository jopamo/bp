# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="clap_builder"
CRATE_VERSION="4.5.52"
CRATE_CHECKSUM="02576b399397b659c26064fbc92a75fede9d18ffd5f80ca1cd74ddab167016e1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A simple to use, efficient, and full-featured Command Line Argument Parser"
HOMEPAGE="https://github.com/clap-rs/clap"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"cargo"
	"color"
	"debug"
	"default"
	"deprecated"
	"env"
	"error-context"
	"help"
	"std"
	"string"
	"suggestions"
	"unicode"
	"unstable-doc"
	"unstable-ext"
	"unstable-styles"
	"unstable-v5"
	"usage"
	"wrap_help"
)
