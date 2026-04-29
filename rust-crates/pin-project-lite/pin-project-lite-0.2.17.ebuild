# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pin-project-lite"
CRATE_VERSION="0.2.17"
CRATE_CHECKSUM="a89322df9ebe1c1578d689c92318e070967d1042b512afbe49518723f4e6d5cd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight version of pin-project written with declarative macros."
HOMEPAGE="https://github.com/taiki-e/pin-project-lite"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
