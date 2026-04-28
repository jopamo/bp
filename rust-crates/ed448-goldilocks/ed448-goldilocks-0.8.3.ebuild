# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ed448-goldilocks"
CRATE_VERSION="0.8.3"
CRATE_CHECKSUM="06924531e9e90130842b012e447f85bdaf9161bc8a0f8092be8cb70b01ebe092"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A pure-Rust implementation of Ed448 and Curve448 and Decaf"
HOMEPAGE="https://github.com/crate-crypto/Ed448-Goldilocks"
LICENSE="BSD-3-Clause"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"fiat_u64_backend"
	"u32_backend"
)
