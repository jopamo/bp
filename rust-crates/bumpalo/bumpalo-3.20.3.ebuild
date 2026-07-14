# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="bumpalo"
CRATE_VERSION="3.20.3"
CRATE_CHECKSUM="72f5acc6cb2ba439de613abc23857ec3d78374d8ed5ac84e9d11336e87da8649"
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
