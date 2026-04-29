# lockstep-managed: cargo-crate
EAPI=8
LOCKSTEP_PAYLOAD_MODE="tree-blake3-v1"

CRATE_NAME="enum_dispatch"
CRATE_VERSION="0.3.13"
CRATE_CHECKSUM="aa18ce2bc66555b3218614519ac839ddb759a7d6720732f979ef8d13be147ecd"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Near drop-in replacement for dynamic-dispatched method calls with up to 10x the speed"
HOMEPAGE="https://gitlab.com/antonok/enum_dispatch"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
