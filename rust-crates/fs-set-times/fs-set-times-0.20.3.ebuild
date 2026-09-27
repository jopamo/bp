# lockstep-managed: cargo-crate
EAPI=8
MERGE_MANIFEST_MODE="tree-blake3-v1"

CRATE_NAME="fs-set-times"
CRATE_VERSION="0.20.3"
CRATE_CHECKSUM="94e7099f6313ecacbe1256e8ff9d617b75d1bcb16a6fddef94866d225a01a14a"
CRATE_SOURCE="registry+https://github.com/rust-lang/crates.io-index"
CRATE_SOURCE_KIND="registry"

inherit cargo-crate

DESCRIPTION="Set filesystem timestamps"
HOMEPAGE="https://github.com/bytecodealliance/fs-set-times"
LICENSE="|| ( Apache-2.0-with-LLVM-exception Apache-2.0 MIT )"
SLOT="${PV}"
KEYWORDS="amd64 arm64"
