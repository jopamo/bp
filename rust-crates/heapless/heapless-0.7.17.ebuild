# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="heapless"
CRATE_VERSION="0.7.17"
CRATE_CHECKSUM="cdc6457c0eb62c71aac4bc17216026d8410337c4126773b9c5daba343f17964f"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="\`static\` friendly data structures that don't require dynamic memory allocation"
HOMEPAGE="https://github.com/japaric/heapless"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"__trybuild"
	"cas"
	"default"
	"defmt-impl"
	"mpmc_large"
	"ufmt-impl"
	"x86-sync-pool"
)
