# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="time-macros"
CRATE_VERSION="0.2.24"
CRATE_CHECKSUM="30cfb0125f12d9c277f35663a0a33f8c30190f4e4574868a330595412d34ebf3"
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
