# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="memmap2"
CRATE_VERSION="0.9.5"
CRATE_CHECKSUM="fd3f7eed9d3848f8b98834af67102b720745c4ec028fcd0aa0239277e7de374f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform Rust API for memory-mapped file IO"
HOMEPAGE="https://github.com/RazrFalcon/memmap2-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
