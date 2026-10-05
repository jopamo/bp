# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bit-set"
CRATE_VERSION="0.9.1"
CRATE_CHECKSUM="34ddef2995421ab6a5c779542c81ee77c115206f4ad9d5a8e05f4ff49716a3dd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A set of bits"
HOMEPAGE="https://github.com/contain-rs/bit-set"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"borsh"
	"borsh_std"
	"default"
	"miniserde"
	"nanoserde"
	"serde"
	"serde_no_std"
	"serde_std"
	"std"
)
