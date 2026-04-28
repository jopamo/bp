# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="prost-derive"
CRATE_VERSION="0.13.3"
CRATE_CHECKSUM="e9552f850d5f0964a4e4d0bf306459ac29323ddfbae05e35a7c0d35cb0803cc5"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Generate encoding and decoding implementations for Prost annotated types."
HOMEPAGE="https://github.com/tokio-rs/prost"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
