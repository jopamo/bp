# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="retry-policies"
CRATE_VERSION="0.5.1"
CRATE_CHECKSUM="46a4bd6027df676bcb752d3724db0ea3c0c5fc1dd0376fec51ac7dcaf9cc69be"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="A collection of plug-and-play retry policies for Rust projects."
HOMEPAGE="https://github.com/TrueLayer/retry-policies"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
