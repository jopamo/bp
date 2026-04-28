# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="fastbloom"
CRATE_VERSION="0.9.0"
CRATE_CHECKSUM="27cea6e7f512d43b098939ff4d5a5d6fe3db07971e1d05176fe26c642d33f5b8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The fastest Bloom filter in Rust. No accuracy compromises. Compatible with any hasher."
HOMEPAGE="https://github.com/tomtomwombat/fastbloom/"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"rand"
	"serde"
)
