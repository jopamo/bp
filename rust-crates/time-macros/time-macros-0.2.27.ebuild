# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="time-macros"
CRATE_VERSION="0.2.27"
CRATE_CHECKSUM="2e70e4c5a0e0a8a4823ad65dfe1a6930e4f4d756dcd9dd7939022b5e8c501215"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for the time crate. This crate is an implementation detail and should not be relied upon directly."
HOMEPAGE="https://github.com/time-rs/time"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"formatting"
	"large-dates"
	"parsing"
	"serde"
)
