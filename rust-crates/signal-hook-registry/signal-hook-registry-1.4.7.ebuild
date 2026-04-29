# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="signal-hook-registry"
CRATE_VERSION="1.4.7"
CRATE_CHECKSUM="7664a098b8e616bdfcc2dc0e9ac44eb231eedf41db4e9fe95d8d32ec728dedad"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Backend crate for signal-hook"
HOMEPAGE="https://github.com/vorner/signal-hook"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
