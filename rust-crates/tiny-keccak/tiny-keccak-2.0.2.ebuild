# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="tiny-keccak"
CRATE_VERSION="2.0.2"
CRATE_CHECKSUM="2c9d3793400a45f954c52e73d068316d76b6f4e36977e3fcebb13a2721e80237"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="An implementation of Keccak derived functions."
HOMEPAGE="https://github.com/debris/tiny-keccak"
LICENSE="CC0-1.0"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"cshake"
	"default"
	"fips202"
	"k12"
	"keccak"
	"kmac"
	"parallel_hash"
	"sha3"
	"shake"
	"sp800"
	"tuple_hash"
)
