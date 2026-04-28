# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="jsonc-parser"
CRATE_VERSION="0.27.0"
CRATE_CHECKSUM="7ec4ac49f13c7b00f435f8a5bb55d725705e2cf620df35a5859321595102eb7e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="JSONC parser."
HOMEPAGE="https://github.com/dprint/jsonc-parser"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cst"
	"error_unicode_width"
	"preserve_order"
	"serde"
)
