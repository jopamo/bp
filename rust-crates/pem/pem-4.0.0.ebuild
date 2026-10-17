# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="pem"
CRATE_VERSION="4.0.0"
CRATE_CHECKSUM="d354a98a3d1251555de99e8fdd8afda05573c31b82f59063a7b0a29b5527f120"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Parse and encode PEM-encoded data."
HOMEPAGE="https://github.com/jcreekmore/pem-rs.git"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde"
	"std"
)
