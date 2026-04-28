# lockstep-managed: cargo-crate
EAPI=8

CRATE_NAME="anyhow"
CRATE_VERSION="1.0.101"
CRATE_CHECKSUM="5f0e0fee31ef5ed1ba1316088939cea399010ed7731dba877ed44aeb407a75ea"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Flexible concrete Error type built on std::error::Error"
HOMEPAGE="https://github.com/dtolnay/anyhow"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"std"
)
