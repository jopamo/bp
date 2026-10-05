# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="libdeflate-sys"
CRATE_VERSION="1.25.2"
CRATE_CHECKSUM="72753e0008ea87963d2f0770042d0df7abe51fafbb8dcaf618ac440f2f1fec0a"
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
)
