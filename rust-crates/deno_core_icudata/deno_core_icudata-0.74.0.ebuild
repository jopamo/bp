# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="deno_core_icudata"
CRATE_VERSION="0.74.0"
CRATE_CHECKSUM="fe4dccb6147bb3f3ba0c7a48e993bfeb999d2c2e47a81badee80e2b370c8d695"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Raw ICU data for use with deno_core"
HOMEPAGE="https://github.com/denoland/deno_core_icudata"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
