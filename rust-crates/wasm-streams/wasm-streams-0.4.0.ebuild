# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="wasm-streams"
CRATE_VERSION="0.4.0"
CRATE_CHECKSUM="b65dc4c90b63b118468cf747d8bf3566c1913ef60be765b5730ead9e0a3ba129"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bridging between web streams and Rust streams using WebAssembly"
HOMEPAGE="https://github.com/MattiasBuelens/wasm-streams/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
