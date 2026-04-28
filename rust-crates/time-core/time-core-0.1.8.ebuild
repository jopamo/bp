# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="time-core"
CRATE_VERSION="0.1.8"
CRATE_CHECKSUM="7694e1cfe791f8d31026952abf09c69ca6f6fa4e1a1229e18988f06a04a12dca"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="This crate is an implementation detail and should not be relied upon directly."
HOMEPAGE="https://github.com/time-rs/time"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"large-dates"
)
