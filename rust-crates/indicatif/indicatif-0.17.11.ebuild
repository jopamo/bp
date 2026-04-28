# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indicatif"
CRATE_VERSION="0.17.11"
CRATE_CHECKSUM="183b3088984b400f4cfac3620d5e076c84da5364016b4f49473de574b2586235"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A progress bar and cli reporting library for Rust"
HOMEPAGE="https://github.com/console-rs/indicatif"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"futures"
	"improved_unicode"
	"in_memory"
)
