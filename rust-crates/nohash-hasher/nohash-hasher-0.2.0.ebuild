# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nohash-hasher"
CRATE_VERSION="0.2.0"
CRATE_CHECKSUM="2bf50223579dc7cdcfb3bfcacf7069ff68243f8c363f62ffa99cf000a6b9c451"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of `std::hash::Hasher` which does not hash at all."
HOMEPAGE="https://github.com/paritytech/nohash-hasher"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
