# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="handlebars"
CRATE_VERSION="6.1.0"
CRATE_CHECKSUM="ce25b617d1375ef96eeb920ae717e3da34a02fc979fe632c75128350f9e1f74a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Handlebars templating implemented in Rust."
HOMEPAGE="https://github.com/sunng87/handlebars-rust"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"dir_source"
	"no_logging"
	"script_helper"
	"string_helpers"
)
