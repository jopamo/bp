# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="fragile"
CRATE_VERSION="2.0.1"
CRATE_CHECKSUM="28dd6caf6059519a65843af8fe2a3ae298b14b80179855aeb4adc2c1934ee619"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Provides wrapper types for sending non-send values to other threads."
HOMEPAGE="https://github.com/mitsuhiko/fragile"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
