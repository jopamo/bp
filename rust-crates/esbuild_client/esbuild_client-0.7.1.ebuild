# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="esbuild_client"
CRATE_VERSION="0.7.1"
CRATE_CHECKSUM="97ec79be0f4b20864729b38953ad77c7f347e436a7532c5f332dce9736aa4b5c"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust implementation of a client for communicating with esbuild's service API over stdio"
HOMEPAGE="https://github.com/denoland/esbuild_client"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
)
