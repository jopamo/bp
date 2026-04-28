# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="hashbrown"
CRATE_VERSION="0.12.3"
CRATE_CHECKSUM="8a9ee70c43aaf417c914396645a0fa852624801b24ebb7ae78fe8272889ac888"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A Rust port of Google's SwissTable hash map"
HOMEPAGE="https://github.com/rust-lang/hashbrown"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ahash-compile-time-rng"
	"default"
	"inline-more"
	"nightly"
	"raw"
	"rustc-dep-of-std"
	"rustc-internal-api"
)
