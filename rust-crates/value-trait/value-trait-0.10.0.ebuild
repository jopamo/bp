# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="value-trait"
CRATE_VERSION="0.10.0"
CRATE_CHECKSUM="bcaa56177466248ba59d693a048c0959ddb67f1151b963f904306312548cf392"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Traits to deal with JSONesque values"
HOMEPAGE="https://github.com/simd-lite/value-trait"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"128bit"
	"c-abi"
	"custom-types"
	"default"
	"portable"
	"runtime-detection"
)
