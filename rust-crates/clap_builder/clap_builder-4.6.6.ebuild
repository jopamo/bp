# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="clap_builder"
CRATE_VERSION="4.6.6"
CRATE_CHECKSUM="7b48fea5a88e9ae728a2dcbedbfc0e730f7d60da42e1cb049a83c9fb8b789889"
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
