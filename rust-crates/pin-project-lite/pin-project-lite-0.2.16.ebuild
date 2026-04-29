# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pin-project-lite"
CRATE_VERSION="0.2.16"
CRATE_CHECKSUM="3b3cff922bd51709b605d9ead9aa71031d81447142d828eb4a6eba76fe619f9b"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A lightweight version of pin-project written with declarative macros."
HOMEPAGE="https://github.com/taiki-e/pin-project-lite"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
