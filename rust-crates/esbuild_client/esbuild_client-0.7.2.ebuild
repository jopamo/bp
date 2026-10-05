# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="esbuild_client"
CRATE_VERSION="0.7.2"
CRATE_CHECKSUM="4aad340fec9a377656190d6fbf205d589c322484c6a1d37ebbf328fe6f541720"
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
