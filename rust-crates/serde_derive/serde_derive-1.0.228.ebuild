# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_derive"
CRATE_VERSION="1.0.228"
CRATE_CHECKSUM="d540f220d3187173da220f885ab66608367b6574e925011a9353e4badda91d79"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Macros 1.1 implementation of #[derive(Serialize, Deserialize)]"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"deserialize_in_place"
)
