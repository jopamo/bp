# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="dprint-core-macros"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="1675ad2b358481f3cc46202040d64ac7a36c4ade414a696df32e0e45421a6e9f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Core formatting macros for dprint-core."
HOMEPAGE="https://github.com/dprint/dprint/tree/main/crates/core-macros"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
