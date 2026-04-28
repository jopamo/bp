# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bumpalo"
CRATE_VERSION="3.19.1"
CRATE_CHECKSUM="5dd9dc738b7a8311c7ade152424974d8115f2cdad61e8dab8dac9f2362298510"
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
