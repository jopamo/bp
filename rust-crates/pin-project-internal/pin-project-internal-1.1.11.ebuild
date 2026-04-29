# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pin-project-internal"
CRATE_VERSION="1.1.11"
CRATE_CHECKSUM="d9b20ed30f105399776b9c883e68e536ef602a16ae6f596d2c473591d6ad64c6"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Implementation detail of the \`pin-project\` crate."
HOMEPAGE="https://github.com/taiki-e/pin-project"
LICENSE="|| ( Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
