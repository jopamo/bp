# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="memmap2"
CRATE_VERSION="0.9.10"
CRATE_CHECKSUM="714098028fe011992e1c3962653c96b2d578c4b4bce9036e15ff220319b1e0e3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform Rust API for memory-mapped file IO"
HOMEPAGE="https://github.com/RazrFalcon/memmap2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
