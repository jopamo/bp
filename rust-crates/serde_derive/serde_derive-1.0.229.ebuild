# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_derive"
CRATE_VERSION="1.0.229"
CRATE_CHECKSUM="e7a5d71263a5a7d47b41f6b3f06ba276f10cc18b0931f1799f710578e2309348"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros 1.1 implementation of #[derive(Serialize, Deserialize)]"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"deserialize_in_place"
)
