# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="ctutils"
CRATE_VERSION="0.4.2"
CRATE_CHECKSUM="7d5515a3834141de9eafb9717ad39eea8247b5674e6066c404e8c4b365d2a29e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Constant-time utility library with selection and equality testing support targeting cryptographic applications. Supports \`const fn\` where appropriate. Built on the \`cmov\` crate which provides architecture-specific predication intrinsics. Heavily inspired by the \`subtle\` crate."
HOMEPAGE="https://github.com/RustCrypto/utils/tree/master/ctselect"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"subtle"
)
