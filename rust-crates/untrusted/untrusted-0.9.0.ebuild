# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="untrusted"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="8ecb6da28b8a351d773b68d5825ac39017e680750f980f3a1a85cd8dd28a47c1"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe, fast, zero-panic, zero-crashing, zero-allocation parsing of untrusted inputs in Rust."
HOMEPAGE="https://github.com/briansmith/untrusted"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
