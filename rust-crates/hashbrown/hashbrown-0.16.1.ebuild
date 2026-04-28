# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashbrown"
CRATE_VERSION="0.16.1"
CRATE_CHECKSUM="841d1cc9bed7f9236f321df977030373f4a4163ae1a7dbfe1a51a2c1a51d9100"
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
