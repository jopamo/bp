# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libdeflater"
CRATE_VERSION="1.25.2"
CRATE_CHECKSUM="d1ee41cf6fb1bb6030dfb59ffb7bc01ab26aade44142084c87f0fc7a1658fe71"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Bindings to libdeflate for DEFLATE (de)compression exposed as non-streaming buffer operations. Contains bindings for raw deflate, zlib, and gzip data."
HOMEPAGE="https://github.com/libdeflater/libdeflater"
LICENSE="Apache-2.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"dynamic"
	"freestanding"
	"use_rust_alloc"
)
