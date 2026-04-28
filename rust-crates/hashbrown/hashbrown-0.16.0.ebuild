# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashbrown"
CRATE_VERSION="0.16.0"
CRATE_CHECKSUM="5419bdc4f6a9207fbeba6d11b604d481addf78ecd10c11ad51e76c2f6482748d"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust port of Google's SwissTable hash map"
HOMEPAGE="https://github.com/rust-lang/hashbrown"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"default-hasher"
	"inline-more"
	"nightly"
	"raw-entry"
	"rustc-dep-of-std"
	"rustc-internal-api"
)
