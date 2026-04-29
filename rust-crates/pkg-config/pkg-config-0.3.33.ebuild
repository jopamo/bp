# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="pkg-config"
CRATE_VERSION="0.3.33"
CRATE_CHECKSUM="19f132c84eca552bf34cab8ec81f1c1dcc229b811638f9d283dceabe58c5569e"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A library to run the pkg-config system tool at build time in order to be used in Cargo build scripts."
HOMEPAGE="https://github.com/rust-lang/pkg-config-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
