# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="borsh"
CRATE_VERSION="1.8.0"
CRATE_CHECKSUM="a88b7ea17d208c4193f2c1e6de3c35fe71f98c96982d5ced308bdcc749ff6e1f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Binary Object Representation Serializer for Hashing"
HOMEPAGE="https://borsh.io"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"de_strict_order"
	"default"
	"derive"
	"rc"
	"std"
	"unstable__schema"
)
