# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cooked-waker"
CRATE_VERSION="5.0.0"
CRATE_CHECKSUM="147be55d677052dabc6b22252d5dd0fd4c29c8c27aa4f2fbef0f94aa003b406f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A safe interface for creating async Wakers"
HOMEPAGE="https://github.com/Lucretiel/cooked-waker"
LICENSE="MPL-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
