# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="ipnetwork"
CRATE_VERSION="0.20.0"
CRATE_CHECKSUM="bf466541e9d546596ee94f9f69590f89473455f88372423e0008fc1a7daf100e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to work with IP CIDRs in Rust"
HOMEPAGE="https://github.com/achanda/ipnetwork"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
)
