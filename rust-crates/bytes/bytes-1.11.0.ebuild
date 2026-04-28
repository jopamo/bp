# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="bytes"
CRATE_VERSION="1.11.0"
CRATE_CHECKSUM="b35204fbdc0b3f4446b89fc1ac2cf84a8a68971995d0bf2e925ec7cd960f9cb3"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Types and traits for working with bytes"
HOMEPAGE="https://github.com/tokio-rs/bytes"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
