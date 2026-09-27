# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="salsa-macro-rules"
CRATE_VERSION="0.28.2"
CRATE_CHECKSUM="85f4b7d4405540bbd6d4ffa52d4322d983f3781954d3073067ac1bdb028459b3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Declarative macros for the salsa crate"
HOMEPAGE="https://github.com/salsa-rs/salsa"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"accumulator"
)
