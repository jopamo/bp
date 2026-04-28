# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="lcms2"
CRATE_VERSION="6.1.0"
CRATE_CHECKSUM="680ec3fa42c36e0af9ca02f20a3742a82229c7f1ee0e6754294de46a80be6f74"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="ICC color profile handling. Rusty wrapper for Little CMS"
HOMEPAGE="https://lib.rs/crates/lcms2"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"static"
)
