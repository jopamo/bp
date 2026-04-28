# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="untrusted"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="a156c684c91ea7d62626509bce3cb4e1d9ed5c4d978f7b4352658f96a4c26b4a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Safe, fast, zero-panic, zero-crashing, zero-allocation parsing of untrusted inputs in Rust."
HOMEPAGE="https://github.com/briansmith/untrusted"
LICENSE="ISC"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
