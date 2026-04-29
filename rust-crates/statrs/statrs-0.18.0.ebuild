# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="statrs"
CRATE_VERSION="0.18.0"
CRATE_CHECKSUM="2a3fe7c28c6512e766b0874335db33c94ad7b8f9054228ae1c2abd47ce7d335e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Statistical computing library for Rust"
HOMEPAGE="https://github.com/statrs-dev/statrs"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"

CARGO_CRATE_FEATURES=(
	"default"
	"nalgebra"
	"rand"
)
