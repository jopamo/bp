# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="rend"
CRATE_VERSION="0.5.2"
CRATE_CHECKSUM="a35e8a6bf28cd121053a66aa2e6a2e3eaffad4a60012179f0e864aa5ffeff215"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Cross-platform, endian-aware primitives for Rust"
HOMEPAGE="https://github.com/djkoloski/rend"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"zerocopy-0_8"
)
