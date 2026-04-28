# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="nibble_vec"
CRATE_VERSION="0.1.0"
CRATE_CHECKSUM="77a5d83df9f36fe23f0c3648c6bbb8b0298bb5f1939c8f2704431371f4b84d43"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Vector data-structure for half-byte values."
HOMEPAGE="https://github.com/michaelsproul/rust_nibble_vec"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"
