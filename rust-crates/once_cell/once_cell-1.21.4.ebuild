# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="once_cell"
CRATE_VERSION="1.21.4"
CRATE_CHECKSUM="9f7c3e4beb33f85d45ae3e3a1792185706c8e16d043238c593331cc7cd313b50"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Single assignment cells and lazy values."
HOMEPAGE="https://github.com/matklad/once_cell"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"atomic-polyfill"
	"critical-section"
	"default"
	"parking_lot"
	"portable-atomic"
	"race"
	"std"
	"unstable"
)
