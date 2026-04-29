# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="bumpalo"
CRATE_VERSION="3.20.2"
CRATE_CHECKSUM="5d20789868f4b01b2f2caec9f5c4e0213b41e3e5702a50157d699ae31ced2fcb"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A fast bump allocation arena for Rust."
HOMEPAGE="https://github.com/fitzgen/bumpalo"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"allocator_api"
	"bench_allocator_api"
	"boxed"
	"collections"
	"default"
	"serde"
	"std"
)
