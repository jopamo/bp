# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="aead-gcm-stream"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="e70c8dec860340effb00f6945c49c0daaa6dac963602750db862eabb74bf7886"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Pure Rust implementaion of AES GCM cipher for data streams"
HOMEPAGE="https://crates.io/crates/aead-gcm-stream"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
