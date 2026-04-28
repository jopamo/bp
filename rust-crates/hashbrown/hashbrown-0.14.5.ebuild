# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashbrown"
CRATE_VERSION="0.14.5"
CRATE_CHECKSUM="e5274423e17b7c9fc20b6e7e208532f9b19825d82dfd615708b70edd83df41f1"
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
	"inline-more"
	"nightly"
	"raw"
	"rustc-dep-of-std"
	"rustc-internal-api"
)
