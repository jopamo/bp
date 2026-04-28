# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anyhow"
CRATE_VERSION="1.0.100"
CRATE_CHECKSUM="a23eb6b1614318a8071c9b2521f36b424b2c83db5eb3a0fead4a6c0809af6e61"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Flexible concrete Error type built on std::error::Error"
HOMEPAGE="https://github.com/dtolnay/anyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="0/${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
