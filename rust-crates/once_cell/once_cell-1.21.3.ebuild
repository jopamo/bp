# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="once_cell"
CRATE_VERSION="1.21.3"
CRATE_CHECKSUM="42f5e15c9953c5e4ccceeb2e7382a716482c34515315f7b03532b8b4e8393d2d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Single assignment cells and lazy values."
HOMEPAGE="https://github.com/matklad/once_cell"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
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
