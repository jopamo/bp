# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="cargo-options"
CRATE_VERSION="0.7.6"
CRATE_CHECKSUM="f89e1d6d6f65fe04d5e21be9de19d31a074e3b7e43aa39ee5b85f4cee16c3188"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Reusable common Cargo command line options"
HOMEPAGE="https://github.com/messense/cargo-options"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"serde"
)
