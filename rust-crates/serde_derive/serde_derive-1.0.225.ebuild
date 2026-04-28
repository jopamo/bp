# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="serde_derive"
CRATE_VERSION="1.0.225"
CRATE_CHECKSUM="0ea936adf78b1f766949a4977b91d2f5595825bd6ec079aa9543ad2685fc4516"
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
