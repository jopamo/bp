# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="serde"
CRATE_VERSION="1.0.223"
CRATE_CHECKSUM="a505d71960adde88e293da5cb5eda57093379f64e61cf77bf0e6a63af07a7bac"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A generic serialization/deserialization framework"
HOMEPAGE="https://serde.rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"alloc"
	"default"
	"derive"
	"rc"
	"std"
	"unstable"
)
