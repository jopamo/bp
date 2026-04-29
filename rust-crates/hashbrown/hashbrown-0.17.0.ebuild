# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashbrown"
CRATE_VERSION="0.17.0"
CRATE_CHECKSUM="4f467dd6dccf739c208452f8014c75c18bb8301b050ad1cfb27153803edb0f51"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust port of Google's SwissTable hash map"
HOMEPAGE="https://github.com/rust-lang/hashbrown"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"default-hasher"
	"inline-more"
	"nightly"
	"raw-entry"
	"rustc-dep-of-std"
	"rustc-internal-api"
	"serde"
)
