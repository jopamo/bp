# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="servo_arc"
CRATE_VERSION="0.4.1"
CRATE_CHECKSUM="204ea332803bd95a0b60388590d59cf6468ec9becf626e2451f1d26a1d972de4"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fork of std::sync::Arc with some extra functionality and without weak references"
HOMEPAGE="https://github.com/servo/stylo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"gecko_refcount_logging"
	"servo"
	"track_alloc_size"
)
