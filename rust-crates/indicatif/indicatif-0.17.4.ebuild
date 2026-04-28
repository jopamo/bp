# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indicatif"
CRATE_VERSION="0.17.4"
CRATE_CHECKSUM="db45317f37ef454e6519b6c3ed7d377e5f23346f0823f86e65ca36912d1d0ef8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A progress bar and cli reporting library for Rust"
HOMEPAGE="https://github.com/console-rs/indicatif"
LICENSE="MIT"
SLOT="0/${PV}"
KEYWORDS="~amd64"

CARGO_CRATE_FEATURES=(
	"default"
	"improved_unicode"
	"in_memory"
)
