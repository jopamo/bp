# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="memmap2"
CRATE_VERSION="0.9.9"
CRATE_CHECKSUM="744133e4a0e0a658e1374cf3bf8e415c4052a15a111acd372764c55b4177d490"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform Rust API for memory-mapped file IO"
HOMEPAGE="https://github.com/RazrFalcon/memmap2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
