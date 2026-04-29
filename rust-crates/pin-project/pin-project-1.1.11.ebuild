# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pin-project"
CRATE_VERSION="1.1.11"
CRATE_CHECKSUM="f1749c7ed4bcaf4c3d0a3efc28538844fb29bcdd7d2b67b2be7e20ba861ff517"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A crate for safe and ergonomic pin-projection."
HOMEPAGE="https://github.com/taiki-e/pin-project"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
