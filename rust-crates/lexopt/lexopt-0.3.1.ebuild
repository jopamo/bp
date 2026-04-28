# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lexopt"
CRATE_VERSION="0.3.1"
CRATE_CHECKSUM="9fa0e2a1fcbe2f6be6c42e342259976206b383122fc152e872795338b5a3f3a7"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Minimalist pedantic command line parser"
HOMEPAGE="https://github.com/blyxxyz/lexopt"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"
