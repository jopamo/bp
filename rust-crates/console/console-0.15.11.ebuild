# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="console"
CRATE_VERSION="0.15.11"
CRATE_CHECKSUM="054ccb5b10f9f2cbf51eb355ca1d05c2d279ce1804688d0db74b4733a5aeafd8"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A terminal and console abstraction for Rust"
HOMEPAGE="https://github.com/console-rs/console"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"ansi-parsing"
	"default"
	"windows-console-colors"
)
