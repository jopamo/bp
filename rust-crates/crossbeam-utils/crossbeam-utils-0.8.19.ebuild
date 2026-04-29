# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="crossbeam-utils"
CRATE_VERSION="0.8.19"
CRATE_CHECKSUM="248e3bacc7dc6baa3b21e405ee045c3047101a49145e7e9eca583ab4c2ca5345"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Utilities for concurrent programming"
HOMEPAGE="https://github.com/crossbeam-rs/crossbeam/tree/master/crossbeam-utils"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nightly"
	"std"
)
