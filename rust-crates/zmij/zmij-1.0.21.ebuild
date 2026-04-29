# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="zmij"
CRATE_VERSION="1.0.21"
CRATE_CHECKSUM="b8848ee67ecc8aedbaf3e4122217aff892639231befc6a1b58d29fff4c2cabaa"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A double-to-string conversion algorithm based on Schubfach and yy"
HOMEPAGE="https://github.com/dtolnay/zmij"
LICENSE="MIT"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
