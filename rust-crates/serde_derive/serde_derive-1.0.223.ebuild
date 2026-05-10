# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde_derive"
CRATE_VERSION="1.0.223"
CRATE_CHECKSUM="3d428d07faf17e306e699ec1e91996e5a165ba5d6bce5b5155173e91a8a01a56"
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
