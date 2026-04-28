# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="indicatif"
CRATE_VERSION="0.18.3"
CRATE_CHECKSUM="9375e112e4b463ec1b1c6c011953545c65a30164fbab5b581df32b3abf0dcb88"
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
