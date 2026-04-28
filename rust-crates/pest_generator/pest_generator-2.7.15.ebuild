# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="pest_generator"
CRATE_VERSION="2.7.15"
CRATE_CHECKSUM="7d1396fd3a870fc7838768d171b4616d5c91f6cc25e377b673d714567d99377b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="pest code generator"
HOMEPAGE="https://pest.rs/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"export-internal"
	"grammar-extras"
	"not-bootstrap-in-src"
	"std"
)
