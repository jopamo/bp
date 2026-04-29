# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="find-msvc-tools"
CRATE_VERSION="0.1.5"
CRATE_CHECKSUM="3a3076410a55c90011c298b04d0cfa770b00fa04e1e3c97d3f6c9de105a03844"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Find windows-specific tools, read MSVC versions from the registry and from COM interfaces"
HOMEPAGE="https://github.com/rust-lang/cc-rs"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
