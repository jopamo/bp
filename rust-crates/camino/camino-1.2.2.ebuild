# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="camino"
CRATE_VERSION="1.2.2"
CRATE_CHECKSUM="e629a66d692cb9ff1a1c664e41771b3dcaf961985a9774c0eb0bd1b51cf60a48"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="UTF-8 paths"
HOMEPAGE="https://github.com/camino-rs/camino"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"proptest1"
	"serde1"
)
