# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="time-macros"
CRATE_VERSION="0.2.18"
CRATE_CHECKSUM="3f252a68540fde3a3877aeea552b832b40ab9a69e318efd078774a01ddee1ccf"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Procedural macros for the time crate. This crate is an implementation detail and should not be relied upon directly."
HOMEPAGE="https://github.com/time-rs/time"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"formatting"
	"large-dates"
	"parsing"
	"serde"
)
