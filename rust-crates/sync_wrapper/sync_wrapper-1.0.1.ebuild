# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="sync_wrapper"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="a7065abeca94b6a8a577f9bd45aa0867a2238b74e8eb67cf10d492bc39351394"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A tool for enlisting the compiler's help in proving the absence of concurrency"
HOMEPAGE="https://docs.rs/sync_wrapper"
LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"futures"
)
