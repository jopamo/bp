# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="num-complex"
CRATE_VERSION="0.2.4"
CRATE_CHECKSUM="b6b19411a9719e753aff12e5187b74d60d3dc449ec3f4dc21e3989c3f554bc95"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Complex numbers implementation for Rust"
HOMEPAGE="https://github.com/rust-num/num-complex"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"i128"
	"std"
)
