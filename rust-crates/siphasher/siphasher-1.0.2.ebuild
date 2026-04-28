# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="siphasher"
CRATE_VERSION="1.0.2"
CRATE_CHECKSUM="b2aa850e253778c88a04c3d7323b043aeda9d3e30d5971937c1855769763678e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="SipHash-2-4, SipHash-1-3 and 128-bit variants in pure Rust"
HOMEPAGE="https://docs.rs/siphasher"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"serde_no_std"
	"serde_std"
	"std"
)
