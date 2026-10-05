# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="diplomat"
CRATE_VERSION="0.15.0"
CRATE_CHECKSUM="7935649d00000f5c5d735448ad3dc07b9738160727017914cf42138b8e8e6611"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="The diplomat FFI generation macro"
HOMEPAGE="https://github.com/rust-diplomat/diplomat"
LICENSE="|| ( MIT Apache-2.0 )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
