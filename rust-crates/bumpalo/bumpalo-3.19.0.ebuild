# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bumpalo"
CRATE_VERSION="3.19.0"
CRATE_CHECKSUM="46c5e41b57b8bba42a04676d81cb89e9ee8e859a1a66f80a5a72e1cb76b34d43"
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
