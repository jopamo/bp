# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="derive-where"
CRATE_VERSION="1.6.0"
CRATE_CHECKSUM="ef941ded77d15ca19b40374869ac6000af1c9f2a4c0f3d4c70926287e6364a8f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Deriving with custom trait bounds"
HOMEPAGE="https://github.com/ModProg/derive-where"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"nightly"
	"safe"
	"serde"
	"zeroize"
	"zeroize-on-drop"
)
