# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="synchronoise"
CRATE_VERSION="1.0.1"
CRATE_CHECKSUM="3dbc01390fc626ce8d1cffe3376ded2b72a11bb70e1c75f404a210e4daa4def2"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Synchronization primitives that build upon the standard library"
HOMEPAGE="https://github.com/QuietMisdreavus/synchronoise"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
